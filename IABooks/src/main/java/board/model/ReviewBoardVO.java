package board.model;

import member.model.MemberVO;
import product.model.CategoryVO;
import product.model.ProductVO;

public class ReviewBoardVO {
	
//	-----------------------------------------	
		private int pk_rnum;		 // 후기번호
		private String fk_pnum;		 // 국제표준도서번호
		private String fk_userid;	 // 회원아이디
		private String re_title;	 // 게시글 제목
		private String re_date; 	 //작성일자
		private int re_readcount;	 // 조회수
		private int re_grade; 		 // 평점
		private String re_contents;  // 게시글 내용
		private String re_passwd; 	 // 글비밀번호
		private String re_writer;    // 작성자
		private int isdelete; 		 // 삭제유무(0:삭제안함, 1:삭제함)
		
		private int reviewCnt;		// 한 제품에 대한 리뷰게시글 수
		
//		-----------------------------------------	
		
		public int getReviewCnt() {
			return reviewCnt;
		}

		public void setReviewCnt(int reviewCnt) {
			this.reviewCnt = reviewCnt;
		}

		private MemberVO member;
		
		private ProductVO product;
		
		private CategoryVO category;
		
		public CategoryVO getCategory() {
			return category;
		}

		public void setCategory(CategoryVO category) {
			this.category = category;
		}

		public MemberVO getMember() {
			return member;
		}

		public ProductVO getProduct() {
			return product;
		}

		public int getPk_rnum() {
			return pk_rnum;
		}
		
		public void setPk_rnum(int pk_rnum) {
			this.pk_rnum = pk_rnum;
		}
		
		public String getFk_pnum() {
			return fk_pnum;
		}
		
		public void setFk_pnum(String fk_pnum) {
			this.fk_pnum = fk_pnum;
		}
		
		public String getFk_userid() {
			return fk_userid;
		}
		
		public void setFk_userid(String fk_userid) {
			this.fk_userid = fk_userid;
		}
		
		public String getRe_title() {
			return re_title;
		}
		
		public void setRe_title(String re_title) {
			this.re_title = re_title;
		}
		
		public String getRe_date() {
			return re_date;
		}
		
		public void setRe_date(String re_date) {
			this.re_date = re_date;
		}
		
		public int getRe_readcount() {
			return re_readcount;
		}
		
		public void setRe_readcount(int re_readcount) {
			this.re_readcount = re_readcount;
		}
		
		public int getRe_grade() {
			return re_grade;
		}
		
		public void setRe_grade(int re_grade) {
			this.re_grade = re_grade;
		}
		
		public String getRe_contents() {
			return re_contents;
		}
		
		public void setRe_contents(String re_contents) {
			this.re_contents = re_contents;
		}
		
		public String getRe_passwd() {
			return re_passwd;
		}
		
		public void setRe_passwd(String re_passwd) {
			this.re_passwd = re_passwd;
		}
		
		public String getRe_writer() {
			return re_writer;
		}
		
		public void setRe_writer(String re_writer) {
			this.re_writer = re_writer;
		}
		
		public int getIsdelete() {
			return isdelete;
		}
		
		public void setIsdelete(int isdelete) {
			this.isdelete = isdelete;
		}

		public void setProduct(ProductVO product) {
			// TODO Auto-generated method stub
			this.product = product;
		}

		public void setMember(MemberVO member) {
			// TODO Auto-generated method stub
			this.member = member;
		}
		
		private int currentNum;			// 현재글 번호
		private String currentTitle;	// 현재글 내용
		private int prev_num;			// 이전글 번호
		private String prev_title;	// 이전글 내용
		private int next_num;			// 다음글 번호
		private String next_title;	// 다음글 내용	

		public int getCurrentNum() {
			return currentNum;
		}

		public void setCurrentNum(int currentNum) {
			this.currentNum = currentNum;
		}

		public String getCurrentTitle() {
			return currentTitle;
		}

		public void setCurrentTitle(String currentTitle) {
			this.currentTitle = currentTitle;
		}

		public int getPrev_num() {
			return prev_num;
		}

		public void setPrev_num(int prev_num) {
			this.prev_num = prev_num;
		}

		public String getPrev_title() {
			return prev_title;
		}

		public void setPrev_title(String prev_title) {
			this.prev_title = prev_title;
		}

		public int getNext_num() {
			return next_num;
		}

		public void setNext_num(int next_num) {
			this.next_num = next_num;
		}

		public String getNext_title() {
			return next_title;
		}

		public void setNext_title(String next_title) {
			this.next_title = next_title;
		}
		
		
}
