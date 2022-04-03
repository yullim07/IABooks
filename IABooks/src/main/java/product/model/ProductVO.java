package product.model;



public class ProductVO {
	private String pk_pro_num; 			//국제표준도서번호
	private int fk_cate_num;   			//카테고리대분류번호
	private String  pro_name;  			//도서명
	private String pro_publish_date;	//출간일
	private String publisher; 			//출판사명
	private int pro_price;   			//도서정가 디폴트 0
	private int pro_saleprice;   		//도서판매가 디폴트 0
	private String pro_index; 			//목차(대용량)
	private int point_rate;   			//포인트적립률 디폴트 0.01
	private String pro_inputdate;     	//도서입고일자 디폴트 sysdate
	private int pro_qty;   				//도서재고량 디폴트 100
	private int pro_sales;  			//판매량 디폴트 0
	private int  pro_viewcnt;    		//조회수(화제의 책) 디폴트 0
	private String pro_size;			//책크기
	private String pro_bindtype;		//제본형태
	private int pro_pages;				//쪽수
	private String pro_imgfile_name;	//이미지파일명
    private int fk_wr_code;  			//저자코드
    private String pro_content;			//도서소개(대용량)
    private int pro_restock; 			//재입고 유무 디폴트 0
    private int pro_soldout; 			//품절유무
    
    private CategoryVO category;
    private WriterVO writer;
 // private ImagefileVO imagefile;  
    
    // ================================================================================= //
    
    
    public ProductVO(){}
    
    
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

	
/*	이미지파일 getter 만들어야되는 곳
	public WriterVO getWriter() {
		return writer;
	}


	public void setWriter(WriterVO writer) {
		this.writer = writer;
	}
*/
	
	
	
	// ================================================================================= //
	
	public ProductVO(String pk_pro_num, int fk_cate_num, String pro_name, String pro_publish_date, String publisher,
			int pro_price, int pro_saleprice, String pro_index, int point_rate, String pro_inputdate, int pro_qty,
			int pro_sales, int pro_viewcnt, String pro_size, String pro_bindtype, int pro_pages,
			String pro_imgfile_name, int fk_wr_code, String pro_content, int pro_restock, int pro_soldout,
			CategoryVO category, WriterVO writer) {
		super();
		this.pk_pro_num = pk_pro_num;
		this.fk_cate_num = fk_cate_num;
		this.pro_name = pro_name;
		this.pro_publish_date = pro_publish_date;
		this.publisher = publisher;
		this.pro_price = pro_price;
		this.pro_saleprice = pro_saleprice;
		this.pro_index = pro_index;
		this.point_rate = point_rate;
		this.pro_inputdate = pro_inputdate;
		this.pro_qty = pro_qty;
		this.pro_sales = pro_sales;
		this.pro_viewcnt = pro_viewcnt;
		this.pro_size = pro_size;
		this.pro_bindtype = pro_bindtype;
		this.pro_pages = pro_pages;
		this.pro_imgfile_name = pro_imgfile_name;
		this.fk_wr_code = fk_wr_code;
		this.pro_content = pro_content;
		this.pro_restock = pro_restock;
		this.pro_soldout = pro_soldout;
		this.category = category;
		this.writer = writer;
	}

	// 상품 상세정보를 가져올 때 필요한 VO(나중에 추가이미지도 추가해야 함)
	public ProductVO(String pk_pro_num, int fk_cate_num, String pro_name, String pro_publish_date, String publisher,
			int pro_price, int pro_saleprice, String pro_index, String pro_inputdate, int pro_qty, int pro_sales,
			int pro_viewcnt, String pro_size, String pro_bindtype, int pro_pages, String pro_imgfile_name,
			int fk_wr_code, String pro_content, CategoryVO category, WriterVO writer) {
		super();
		this.pk_pro_num = pk_pro_num;
		this.fk_cate_num = fk_cate_num;
		this.pro_name = pro_name;
		this.pro_publish_date = pro_publish_date;
		this.publisher = publisher;
		this.pro_price = pro_price;
		this.pro_saleprice = pro_saleprice;
		this.pro_index = pro_index;
		this.pro_inputdate = pro_inputdate;
		this.pro_qty = pro_qty;
		this.pro_sales = pro_sales;
		this.pro_viewcnt = pro_viewcnt;
		this.pro_size = pro_size;
		this.pro_bindtype = pro_bindtype;
		this.pro_pages = pro_pages;
		this.pro_imgfile_name = pro_imgfile_name;
		this.fk_wr_code = fk_wr_code;
		this.pro_content = pro_content;
		this.category = category;
		this.writer = writer;
	}
	
	// ================================================================================= //
	
	
	public String getPk_pro_num() {
		return pk_pro_num;
	}


	public int getPro_soldout() {
		return pro_soldout;
	}


	public void setPro_soldout(int pro_soldout) {
		this.pro_soldout = pro_soldout;
	}


	public int getPro_restock() {
		return pro_restock;
	}


	public void setPro_restock(int pro_restock) {
		this.pro_restock = pro_restock;
	}


	


	public void setPk_pro_num(String pk_pro_num) {
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

	public String getPro_publish_date() {
		return pro_publish_date;
	}


	public void setPro_publish_date(String pro_publish_date) {
		this.pro_publish_date = pro_publish_date;
	}


	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getPro_price() {
		return pro_price;
	}

	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}

	public int getPro_saleprice() {
		return pro_saleprice;
	}

	public void setPro_saleprice(int pro_saleprice) {
		this.pro_saleprice = pro_saleprice;
	}

	public String getPro_index() {
		return pro_index;
	}

	public void setPro_index(String pro_index) {
		this.pro_index = pro_index;
	}

	public int getPoint_rate() {
		return point_rate;
	}

	public void setPoint_rate(int point_rate) {
		this.point_rate = point_rate;
	}

	public String getPro_inputdate() {
		return pro_inputdate;
	}

	public void setPro_inputdate(String pro_inputdate) {
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

	public String getPro_size() {
		return pro_size;
	}

	public void setPro_size(String pro_size) {
		this.pro_size = pro_size;
	}

	public String getPro_bindtype() {
		return pro_bindtype;
	}

	public void setPro_bindtype(String pro_bindtype) {
		this.pro_bindtype = pro_bindtype;
	}

	public int getPro_pages() {
		return pro_pages;
	}

	public void setPro_pages(int pro_pages) {
		this.pro_pages = pro_pages;
	}

	public String getPro_imgfile_name() {
		return pro_imgfile_name;
	}

	public void setPro_imgfile_name(String pro_imgfile_name) {
		this.pro_imgfile_name = pro_imgfile_name;
	}

	public int getFk_wr_code() {
		return fk_wr_code;
	}

	public void setFk_wr_code(int fk_wr_code) {
		this.fk_wr_code = fk_wr_code;
	}

	public String getPro_content() {
		return pro_content;
	}

	public void setPro_content(String pro_content) {
		this.pro_content = pro_content;
	}
	
}
