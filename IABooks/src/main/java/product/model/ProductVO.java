package product.model;

public class ProductVO {
	private int pk_pro_num; 		//국제표준도서번호
	private int fk_cate_num;   		//카테고리대분류번호
	private String  pro_name;  		//도서명
	private String fk_wr_code;  	//저자코드
	private String publisher; 		//출판사명
	private String publish_date;	//출간일
	private int fk_imgfileno;   	//이미지번호
    private int pro_price;   		//도서정가
    private int saleprice;   		//도서판매가
    private int fk_spec_num;  	 	//스펙번호
    private String pro_index; 		//목차
    private String pro_content;		//도서소개
    private int point_rate;   		//포인트적립률
    private int pro_inputdate;      //도서입고일자
    private int pro_qty;   			//도서재고량
    private int pro_sales;  		//판매량
    private int  pro_viewcnt;    	//조회수(화제의 책)
	
    public ProductVO() {}
    
	public ProductVO(int pk_pro_num, int fk_cate_num, String pro_name, String fk_wr_code, String publisher,
			String publish_date, int fk_imgfileno, int pro_price, int saleprice, int fk_spec_num, String pro_index,
			String pro_content, int point_rate, int pro_inputdate, int pro_qty, int pro_sales, int pro_viewcnt) {
		super();
		this.pk_pro_num = pk_pro_num;
		this.fk_cate_num = fk_cate_num;
		this.pro_name = pro_name;
		this.fk_wr_code = fk_wr_code;
		this.publisher = publisher;
		this.publish_date = publish_date;
		this.fk_imgfileno = fk_imgfileno;
		this.pro_price = pro_price;
		this.saleprice = saleprice;
		this.fk_spec_num = fk_spec_num;
		this.pro_index = pro_index;
		this.pro_content = pro_content;
		this.point_rate = point_rate;
		this.pro_inputdate = pro_inputdate;
		this.pro_qty = pro_qty;
		this.pro_sales = pro_sales;
		this.pro_viewcnt = pro_viewcnt;
	}
	
	public int getPk_pro_num() {
		return pk_pro_num;
	}
	
	public void setPk_pro_num(int pk_pro_num) {
		this.pk_pro_num = pk_pro_num;
	}
	
	public int getFk_cate_num() {
		return fk_cate_num;
	}
	
	public void setFk_cate_num(int fk_cate_num) {
		this.fk_cate_num = fk_cate_num;
	}
	
	public String getPro_name() {
		return pro_name;
	}
	
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	
	public String getFk_wr_code() {
		return fk_wr_code;
	}
	
	public void setFk_wr_code(String fk_wr_code) {
		this.fk_wr_code = fk_wr_code;
	}
	
	public String getPublisher() {
		return publisher;
	}
	
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	
	public String getPublish_date() {
		return publish_date;
	}
	
	public void setPublish_date(String publish_date) {
		this.publish_date = publish_date;
	}
	
	public int getFk_imgfileno() {
		return fk_imgfileno;
	}
	
	public void setFk_imgfileno(int fk_imgfileno) {
		this.fk_imgfileno = fk_imgfileno;
	}
	
	public int getPro_price() {
		return pro_price;
	}
	
	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}
	
	public int getSaleprice() {
		return saleprice;
	}
	
	public void setSaleprice(int saleprice) {
		this.saleprice = saleprice;
	}
	
	public int getFk_spec_num() {
		return fk_spec_num;
	}
	
	public void setFk_spec_num(int fk_spec_num) {
		this.fk_spec_num = fk_spec_num;
	}
	
	public String getPro_index() {
		return pro_index;
	}
	
	public void setPro_index(String pro_index) {
		this.pro_index = pro_index;
	}
	
	public String getPro_content() {
		return pro_content;
	}
	
	public void setPro_content(String pro_content) {
		this.pro_content = pro_content;
	}
	
	public int getPoint_rate() {
		return point_rate;
	}
	
	public void setPoint_rate(int point_rate) {
		this.point_rate = point_rate;
	}
	
	public int getPro_inputdate() {
		return pro_inputdate;
	}
	
	public void setPro_inputdate(int pro_inputdate) {
		this.pro_inputdate = pro_inputdate;
	}
	
	public int getPro_qty() {
		return pro_qty;
	}
	
	public void setPro_qty(int pro_qty) {
		this.pro_qty = pro_qty;
	}
	
	public int getPro_sales() {
		return pro_sales;
	}
	
	public void setPro_sales(int pro_sales) {
		this.pro_sales = pro_sales;
	}
	
	public int getPro_viewcnt() {
		return pro_viewcnt;
	}
	
	public void setPro_viewcnt(int pro_viewcnt) {
		this.pro_viewcnt = pro_viewcnt;
	}

	
}
