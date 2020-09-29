package vo;
import dao.*;

public class Paging {
	// 현재 페이지를 담는 변수 생성(초기값: 1)
	private int currentPage = 1;
	// 한 페이지에 출력되는 행의 수(초기값: 10행 출력)
	private int rowPerPage = 10;
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	// 상품리스트의 전체 행 개수를 구하는 메서드
	public int getLastPage() throws Exception {
		//전체 페이지를 담는 변수
		int totalPage = 0;
		//Dao객체 접근
		ProductDao productDao = new ProductDao();
		//마지막 페이지
		totalPage = productDao.selectCount();
		int lastPage = totalPage/rowPerPage;		
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}		
		return lastPage;
	}
	// 카테고리 별 전체 행을 구하는 메서드
	public int getLastPageByCategory(int categoryId) throws Exception {
		//전체 페이지를 담는 변수
		int totalPage = 0;
		//Dao객체 접근
		ProductDao productDao = new ProductDao();
		//마지막 페이지
		totalPage = productDao.selectCountByCategoryId(categoryId);
		int lastPage = totalPage/rowPerPage;	// <-- 전체 행 수/현재 행의 수
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}		
		System.out.println(categoryId + "<-- 넘어온 카테고리 넘버");
//		System.out.println(totalPage + "<-- 카테고리 전체 행의 수");
		System.out.println(lastPage + "<-- 카테고리 라스트 페이지");
		return lastPage;
	}
}
