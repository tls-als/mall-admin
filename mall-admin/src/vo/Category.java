package vo;

// 결과값을 담는 클래스
public class Category {
	private int categoryId;	//카테고리 ID를 담는 변수
	private String categoryName;	// 카테고리 PW를 담는 변수
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
}
