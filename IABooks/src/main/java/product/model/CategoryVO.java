package product.model;

public class CategoryVO {

	private int pk_cate_num;
	private String cate_name;
	
	
	public CategoryVO() {};
	
	public CategoryVO(int pk_cate_num, String cate_name) {
		super();
		this.pk_cate_num = pk_cate_num;
		this.cate_name = cate_name;
	}
	
	public int getPk_cate_num() {
		return pk_cate_num;
	}
	public void setPk_cate_num(int pk_cate_num) {
		this.pk_cate_num = pk_cate_num;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	
	
}
