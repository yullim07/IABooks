package product.controller3.test;

import product.model.CategoryVO;
import product.model.ProductVO;
import product.model.WriterVO;

public class WishListVO {

	private int pk_wnum;				// 관심상품번호       
	private String fk_userid; 			// 사용자 아이디
	private String fk_pnum; 			// 국제표준도서번호
	private String wdate;				// 관심상품등록일자
	private int w_status;				// 관심상품 등록여부(1이면 등록, 0이면 아님) 
	
	private ProductVO product;
	private CategoryVO category;
    private WriterVO writer;
    
    
    // ================================================================
    
    public WishListVO() {
    	
    }

	public WishListVO(int pk_wnum, String fk_userid, String fk_pnum, String wdate,
    				  ProductVO product, CategoryVO category, WriterVO writer) {
    	super();
    	this.pk_wnum = pk_wnum;
    	this.fk_userid = fk_userid;
    	this.fk_pnum = fk_pnum;
    	this.wdate = wdate; 
    	this.product = product;
    	this.category = category;
    	this.writer = writer;
    	
    }
    
	public int getPk_wnum() {
		return pk_wnum;
	}
	
	public void setPk_wnum(int pk_wnum) {
		this.pk_wnum = pk_wnum;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_pnum() {
		return fk_pnum;
	}
	
	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	
	public String getWdate() {
		return wdate;
	}
	
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	
	public int getW_status() {
		return w_status;
	}

	public void setW_status(int w_status) {
		this.w_status = w_status;
	}
	
	public ProductVO getProduct() {
		return product;
	}
	
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	
	public CategoryVO getCategory() {
		return category;
	}
	
	public void setCategory(CategoryVO category) {
		this.category = category;
	}
	
	public WriterVO getWriter() {
		return writer;
	}
	
	public void setWriter(WriterVO writer) {
		this.writer = writer;
	}
	
}

