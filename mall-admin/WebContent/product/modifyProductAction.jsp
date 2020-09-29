<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1. 상품아이디와 이미지 파일을 받음.
	// 2. 이미지파일을 서버 / images 폴더에 새로운 이름으로 저장함
	// 3. 저장된 이미지의 이름을 상품테이블에서 수정한다 ex) default.jpg -> 새로 생선된 이름으로 변경

	/* enctype="multipart/form-data" 방식은 기존방식(getParameter) 사용 불가
	String productId = request.getParameter("productId");
	String productPic = request.getParameter("productPic");
	System.out.println(productId + "<-- productId");	// null
	System.out.println(productPic + "<-- productPic");	// null	-> enc타입이 utf-8이 아닌 multipart 형태로 받았기 때문
	*/
	
	// cos.jar 외부라이브러리 사용(내부 라이브러리 사용도 가능하지만 사용법이 복잡)
	
	// MultipartRequest 객체 생성
	// DefaultFileRenamePolicy dfp = new DefaultFileRenamePolicy();
	int size = 1024 * 1024 * 100; //100MB. B 바이트 , b 비트
	// 시스템에게 이미지 폴더의 실제 위치를 구함(배포시에 위치가 달라질 수 있기 때문)
	String path = application.getRealPath("image"); // D:\javawork\mall-admin\WebContent\image
	// MultipartRequest(매개변수,경로,크기,인코딩,파일이름을 만드는 객체). 해당 객체는 파일이름을 자동으로 생성(변환)해줌.
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	
	// MultipartRequest로 상품 아이디 받기
	int productId = 0;
	if(multi.getParameter("productId") != null) {
		productId = Integer.parseInt(multi.getParameter("productId"));
	}
	System.out.println(productId + "<-- productId");
	
	// System.out.println(multi.getOriginalFileName("productPic") + "<-- 파일 원본이름");
	// MultipartRequest로 상품 사진 받기
	String productPic = multi.getFilesystemName("productPic"); //db에 들어가는 이름
	System.out.println(multi.getFilesystemName("productPic") + "<-- 새로생성된 파일이름");	//D:\javawork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\mall-admin\image
	
	// 데이터를 담을 vo 객체 생성
	Product product = new Product();
	product.setProductId(productId);	// 상품 번호
	product.setProductPic(productPic);	// 상품 이미지 파일 이름
	
	// update product set product_pic = ? where product_id = ?
	// 업데이트를 위한 Dao 객체 생성
	ProductDao productDao = new ProductDao();
	productDao.updateProductPic(product);
	
	response.sendRedirect("/mall-admin/product/productList.jsp");
%>