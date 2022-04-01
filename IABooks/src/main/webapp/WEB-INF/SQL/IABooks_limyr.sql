select * from tabs;

-- 제품
CREATE TABLE tbl_product (
	pk_pro_num    NUMBER       NOT NULL, -- 국제표준도서번호
	fk_cate_num   NUMBER(1)    NOT NULL, -- 카테고리대분류번호
	pro_name      VARCHAR2(20)  NOT NULL, -- 도서명
	fk_wr_code    VARCHAR2(20)  NOT NULL, -- 저자코드
	publisher     VARCHAR2(50)  NULL,     -- 출판사명
	publish_date  VARCHAR2(12)  NULL,     -- 출간일
	fk_imgfileno  NUMBER(8)    NOT NULL, -- 이미지번호
	pro_price     NUMBER(8)    DEFAULT 0, -- 도서정가
	saleprice     NUMBER(8)    DEFAULT 0, -- 도서판매가
	fk_spec_num   NUMBER(8)    NOT NULL, -- 스펙번호
	pro_index     VARCHAR2(100) NULL,     -- 목차
	pro_content   VARCHAR2(100) NULL,     -- 도서소개
	point_rate    NUMBER(3)    DEFAULT 0, -- 포인트적립률
	pro_inputdate DATE         DEFAULT sysdate, -- 도서입고일자
	pro_qty       NUMBER(20)   DEFAULT 0, -- 도서재고량
	pro_sales     NUMBER(20)   DEFAULT 0, -- 판매량
    pro_viewcnt   NUMBER(8)    DEFAULT 0 -- 조회수(화제의 책)
);
-- Table TBL_PRODUCT이(가) 생성되었습니다.


-- 제품
ALTER TABLE tbl_product
	ADD
		CONSTRAINT PK_tbl_product -- 제품 기본키
		PRIMARY KEY (
			pk_pro_num -- 국제표준도서번호
		);
-- Table TBL_PRODUCT이(가) 변경되었습니다.

-- 저자
CREATE TABLE tbl_writer (
	pk_wr_code VARCHAR2(20)  NOT NULL, -- 저자코드
	wr_name    VARCHAR2(20)  NULL,     -- 저자명
	wr_info    VARCHAR2(100) NULL      -- 저자소개
);
-- Table TBL_WRITER이(가) 생성되었습니다.

-- 저자
ALTER TABLE tbl_writer
	ADD
		CONSTRAINT PK_tbl_writer -- 저자 기본키
		PRIMARY KEY (
			pk_wr_code -- 저자코드
		);
-- Table TBL_WRITER이(가) 변경되었습니다.

-- 도서스펙
CREATE TABLE tbl_spec (
	pk_spec_num NUMBER(8)   NOT NULL, -- 스펙번호
	fk_cate_num NUMBER(1)   NOT NULL, -- 카테고리대분류번호
	spec_size   VARCHAR2(20) NULL,     -- 크기
	ck_bindtype VARCHAR2(20) NULL,     -- 제본형태
	spec_pages  VARCHAR2(20) NULL      -- 쪽수
);
-- Table TBL_SPEC이(가) 생성되었습니다.

-- 도서스펙
ALTER TABLE tbl_spec
	ADD
		CONSTRAINT PK_tbl_spec -- 도서스펙 기본키
		PRIMARY KEY (
			pk_spec_num -- 스펙번호
		);
-- Table TBL_SPEC이(가) 변경되었습니다.

-- 도서스펙
ALTER TABLE tbl_spec
	ADD
		CONSTRAINT CK_tbl_spec_bindtype -- 도서스펙제본형태체크
		CHECK (ck_bindtype in ('양장제본', '반양장제본', '무선제본', '낱장제본', '기타'));
-- Table TBL_SPEC이(가) 변경되었습니다.

-- 도서 카테고리
CREATE TABLE tbl_category (
	pk_cate_num  NUMBER(1)   NOT NULL, -- 카테고리대분류번호
	ck_cate_name VARCHAR2(10) NOT NULL  -- 카테고리명
);
-- Table TBL_CATEGORY이(가) 생성되었습니다.

-- 도서 카테고리
ALTER TABLE tbl_category
	ADD
		CONSTRAINT PK_tbl_category -- 도서 카테고리 기본키
		PRIMARY KEY (
			pk_cate_num -- 카테고리대분류번호
		);
-- Table TBL_CATEGORY이(가) 변경되었습니다.

---- 도서 카테고리
--ALTER TABLE tbl_category
--	ADD
--		CONSTRAINT UK_tbl_category -- 도서 카테고리 유니크 제약
--		UNIQUE (
--		);

-- 도서 카테고리
ALTER TABLE tbl_category
	ADD
		CONSTRAINT CK_tbl_category_cate_name -- 도서카테고리명체크
		CHECK (ck_cate_name in ('인문', '사회', '과학'));
-- Table TBL_CATEGORY이(가) 변경되었습니다.

-- 제품추가이미지
CREATE TABLE tbl_product_imagefile (
	pk_imgfileno   NUMBER(8)   NOT NULL, -- 이미지번호
	fk_pro_num     NUMBER      NOT NULL, -- 국제표준도서번호
	imgfilename VARCHAR2(50)         -- 이미지파일명
);
-- Table TBL_PRODUCT_IMAGEFILE이(가) 생성되었습니다.
desc tbl_product_imagefile;
-- 제품추가이미지
ALTER TABLE tbl_product_imagefile
	ADD
		CONSTRAINT PK_tbl_product_imagefile -- 제품추가이미지 기본키
		PRIMARY KEY (
			pk_imgfileno -- 이미지번호
		);
-- Table TBL_PRODUCT_IMAGEFILE이(가) 변경되었습니다.

-- 제품추가이미지
--ALTER TABLE tbl_product_imagefile
--	ADD
--		CONSTRAINT UK_tbl_product_imagefile -- 제품추가이미지 유니크 제약
--		UNIQUE (
--			uq_imgfilename -- 이미지파일명
--		);

-- 주문상세
CREATE TABLE tbl_orderdetail (
	pk_odr_seqnum    VARCHAR2(25) NOT NULL, -- 주문상세일련번호
	fk_odrcode      VARCHAR2(25) NOT NULL, -- 주문코드
	pk_pro_num       NUMBER      NULL,     -- 국제표준도서번호
	ck_odr_totalqty  NUMBER      NOT NULL, -- 총주문량
	odr_price        NUMBER      NOT NULL, -- 주문가격
	ck_deliverstatus VARCHAR2(25) NOT NULL, -- 배송상태
	ck_deliverdate   DATE        NULL      -- 배송완료일자
);
-- Table TBL_ORDERDETAIL이(가) 생성되었습니다.

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT PK_tbl_orderdetail -- 주문상세 기본키
		PRIMARY KEY (
			pk_odr_seqnum -- 주문상세일련번호
		);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.
 

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT UK_tbl_orderdetail -- 주문상세 유니크 제약
		UNIQUE (
			fk_odrcode -- 주문코드
		);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT CK_odrdetail_totalqty -- 주문상세 총주문량 체크
		CHECK (ck_odr_totalqty > 0);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT CK_odrdetail_deliverstatus -- 주문상세 주문상태 체크
		CHECK (ck_deliverstatus in('발송준비', '배송준비', '배송중', '배송완료', '배송실패'));
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

-- 주문상세                                                                         ------------------------------- 나중에
--ALTER TABLE tbl_orderdetail
--	ADD
--		CONSTRAINT CK_odrdetail_deliverdate -- 주문상태 배송완료일자 체크 필요없음
--		CHECK (ck_deliverdate > sysdate);

-- 주문
--CREATE TABLE tbl_order (
--	pk_odrcode     VARCHAR2(25)  NOT NULL, -- 주문코드
--	fk_userid      VARCHAR2(20)  NOT NULL, -- 회원아이디
--	odr_totalprice NUMBER(10)   NOT NULL, -- 주문총액
--	odr_totalpoint NUMBER       DEFAULT 0, -- 주문총포인트
--	odr_date       DATE         DEFAULT sysdate, -- 주문일자
--	rv_name        VARCHAR2(8)   NOT NULL, -- 이름
--	rv_zipcode     VARCHAR2(5)   NOT NULL, -- 우편번호
--	rv_addr1       VARCHAR2(100) NOT NULL, -- 기본주소
--	rv_addr2       VARCHAR2(100) NOT NULL, -- 상세주소
--	rv_phone       NUMBER(11)   NOT NULL, -- 휴대전화
--	rv_email       VARCHAR2(200)  NOT NULL, -- 이메일
--	del_msg        VARCHAR2(50)  NULL      -- 배송메시지
--);

-- 주문
--ALTER TABLE tbl_order
--	ADD
--		CONSTRAINT PK_tbl_order -- 주문 기본키
--		PRIMARY KEY (
--			pk_odrcode -- 주문코드
--		);
--
---- 주문
--ALTER TABLE tbl_order
--	ADD
--		CONSTRAINT UK_tbl_order -- 주문 유니크 제약
--		UNIQUE (
--			rv_email,  -- 이메일
--			fk_userid, -- 회원아이디
--			rv_phone   -- 휴대전화
--		);
--
---- 주문
--ALTER TABLE tbl_order
--	ADD
--		CONSTRAINT CK_tbl_order_totalprice -- 주문총액체크
--		CHECK (ck_odr_totalprice > 0);
--
---- 주문
--ALTER TABLE tbl_order
--	ADD
--		CONSTRAINT CK_tbl_order_odr_totalpoint -- 주문총포인트체크
--		CHECK (ck_odr_totalpoint >= 0);
--
---- 주문
--ALTER TABLE tbl_order
--	ADD
--		CONSTRAINT CK_tbl_order_odr_date -- 주문일자체크
--		CHECK (ck_odr_date > sysdate);
--
---- 장바구니
--CREATE TABLE tbl_cart (
--	pk_cartno        NUMBER      NOT NULL, -- 장바구니번호
--	fk_userid        VARCHAR(20) NOT NULL, -- 회원아이디
--	pk_pro_num       NUMBER      NULL,     -- 국제표준도서번호
--	ck_odr_qty       NUMBER(4)   NOT NULL DEFAULT 0, -- 주문량
--	ck_cart_register DATE        NOT NULL DEFAULT sysdate -- 입력일자
--);
--
---- 장바구니
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT PK_tbl_cart -- 장바구니 기본키
--		PRIMARY KEY (
--			pk_cartno -- 장바구니번호
--		);
--
---- 장바구니
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT UK_tbl_cart -- 장바구니 유니크 제약
--		UNIQUE (
--			fk_userid -- 회원아이디
--		);
--
---- 장바구니
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT CK_tbl_cart_odr_qty -- 장바구니주문량체크
--		CHECK (ck_odr_qty > 0);
--
---- 장바구니   ------------------------------------------------------------------------------ 나중에
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT CK_tbl_cart_cart_register -- 장바구니입력일자체크크
--		CHECK (ck_cart_register > sysdate);
--
---- 임시 테이블
--CREATE TABLE Temporary (
--	re_passwd VARCHAR(20) NOT NULL -- 글비밀번호
--);

-- 제품
ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_writer_TO_tbl_product -- 저자 -> 제품
		FOREIGN KEY (
			fk_wr_code -- 저자코드
		)
		REFERENCES tbl_writer ( -- 저자
			pk_wr_code -- 저자코드
		);
-- Table TBL_PRODUCT이(가) 변경되었습니다.

-- 제품
ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_spec_TO_tbl_product -- 도서스펙 -> 제품
		FOREIGN KEY (
			fk_spec_num -- 스펙번호
		)
		REFERENCES tbl_spec ( -- 도서스펙
			pk_spec_num -- 스펙번호
		);
-- Table TBL_PRODUCT이(가) 변경되었습니다.

-- 제품
ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_category_TO_tbl_product -- 도서 카테고리 -> 제품
		FOREIGN KEY (
			fk_cate_num -- 카테고리대분류번호
		)
		REFERENCES tbl_category ( -- 도서 카테고리
			pk_cate_num -- 카테고리대분류번호
		);
-- Table TBL_PRODUCT이(가) 변경되었습니다.

-- 제품
ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_pro_imgfile_TO_tbl_pro -- 제품추가이미지 -> 제품
		FOREIGN KEY (
			fk_imgfileno -- 이미지번호
		)
		REFERENCES tbl_product_imagefile ( -- 제품추가이미지
			pk_imgfileno -- 이미지번호
		);
-- Table TBL_PRODUCT이(가) 변경되었습니다.

-- 도서스펙
ALTER TABLE tbl_spec
	ADD
		CONSTRAINT FK_tbl_category_TO_tbl_spec -- 도서 카테고리 -> 도서스펙
		FOREIGN KEY (
			fk_cate_num -- 카테고리대분류번호
		)
		REFERENCES tbl_category ( -- 도서 카테고리
			pk_cate_num -- 카테고리대분류번호
		);
-- Table TBL_SPEC이(가) 변경되었습니다.

-- 제품추가이미지
ALTER TABLE tbl_product_imagefile
	ADD
		CONSTRAINT FK_tbl_pro_TO_tbl_pro_imgfile -- 제품 -> 제품추가이미지
		FOREIGN KEY (
			fk_pro_num -- 국제표준도서번호
		)
		REFERENCES tbl_product ( -- 제품
			pk_pro_num -- 국제표준도서번호
		);
-- Table TBL_PRODUCT_IMAGEFILE이(가) 변경되었습니다.     
        
        
select * from tbl_order;

---- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT FK_tbl_odr_TO_tbl_odrdetail -- 주문 -> 주문상세
		FOREIGN KEY (
			fk_ord_code -- 주문코드
		)
		REFERENCES tbl_order ( -- 주문
			pk_odrcode -- 주문코드
		);
        
desc tbl_orderdetail;


--
---- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT FK_tbl_pro_TO_tbl_odrdetail -- 제품 -> 주문상세
		FOREIGN KEY (
			pk_pro_num -- 국제표준도서번호
		)
		REFERENCES tbl_product ( -- 제품
			pk_pro_num -- 국제표준도서번호
		);


---- 주문
ALTER TABLE tbl_order
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_order -- 회원 -> 주문
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);

desc tbl_cart;

---- 장바구니
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT FK_tbl_member_TO_tbl_cart -- 회원 -> 장바구니
--		FOREIGN KEY (
--			fk_userid -- 회원아이디
--		)
--		REFERENCES tbl_member ( -- 회원
--			pk_userid -- 회원아이디
--		);
--
---- 장바구니
--ALTER TABLE tbl_cart
--	ADD
--		CONSTRAINT FK_tbl_product_TO_tbl_cart -- 제품 -> 장바구니
--		FOREIGN KEY (
--			pk_pro_num -- 국제표준도서번호
--		)
--		REFERENCES tbl_product ( -- 제품
--			pk_pro_num -- 국제표준도서번호
--		);




--------------------------------------------------------------------------------

select * from tab;

select constraint_name, constraint_type, r_constraint_name
from user_constraints
where table_name = 'TBL_ORDER';

select constraint_name, constraint_type, r_constraint_name
from user_constraints
where table_name = 'tbl_faq_board';

-- tbl_cart  TBL_CATEGORY TBL_ORDER  TBL_ORDERDETAIL TBL_PRODUCT TBL_PRODUCT_IMAGEFILE
-- TBL_SPEC TBL_WRITER

--select *
--from user_constraints A JOIN user_cons_columns B
--ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
--where A.table_name = '테이블명';

desc tbl_order;
desc tbl_orderdetail;

select *
from user_constraints
where table_name = 'tbl_orderdetail';
 
select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = 'tbl_cart';

commit;


select * from tab;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
select * from tab;
select * from TBL_CART;
select * from TBL_CATEGORY;
select * from TBL_COMMENT;
select * from TBL_FAQ_BOARD;
select * from TBL_FAQ_CATEGORY;
select * from TBL_LOGINHISTORY;
select * from TBL_MEMBER;
select * from TBL_ORDER;
select * from TBL_ORDERDETAIL;
select * from TBL_PRODUCT;
select * from TBL_PRODUCT_IMAGEFILE;
select * from TBL_QNA_BOARD;
select * from TBL_REVIEW_BOARD;
select * from TBL_WRITER;


select *
from TBL_PRODUCT
where fk_cate_num=101;


desc tbl_product;
desc TBL_PRODUCT_IMAGEFILE;


select *
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = 'tbl_product';










------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

-- 제품팀 테이블

select * from tab;
select * from TBL_CART;
select * from TBL_CATEGORY;
select * from TBL_COMMENT;
select * from TBL_FAQ_BOARD;
select * from TBL_FAQ_CATEGORY;
select * from TBL_LOGINHISTORY;
select * from TBL_MEMBER;
select * from TBL_ORDER;
select * from TBL_ORDERDETAIL;
select * from TBL_PRODUCT;
select * from TBL_PRODUCT_IMAGEFILE;
select * from TBL_QNA_BOARD;
select * from TBL_REVIEW_BOARD;
select * from TBL_WRITER;

select *
    from user_constraints
    where table_name = 'tbl_orderdetail';
    
select *
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = 'tbl_orderdetail';



---------- 제약조건 지우고 다시 만들기----------------------------------------------------------------------------------------------------------------

-- 주문상세 테이블 제약조건 삭제 후 다시 만들기
alter table tbl_orderdetail
drop constraint PK_tbl_orderdetail;

alter table tbl_orderdetail
drop constraint UK_tbl_orderdetail;

alter table tbl_orderdetail
drop constraint CK_odrdetail_totalqty;

alter table tbl_orderdetail
drop constraint CK_odrdetail_deliverstatus;




-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT PK_tbl_orderdetail -- 주문상세 기본키
		PRIMARY KEY (
			pk_odr_seqnum -- 주문상세일련번호
		);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.
 

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT UK_tbl_orderdetail -- 주문상세 유니크 제약
		UNIQUE (
			fk_odrcode -- 주문코드
		);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

-- 주문상세
ALTER TABLE tbl_orderdetail
ADD
		CONSTRAINT CK_odrdetail_totalqty -- 주문상세 총주문량 체크
		CHECK (ck_odr_totalqty > 0);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

-- 주문상세
ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT CK_odrdetail_deliverstatus -- 주문상세 주문상태 체크
		CHECK (ck_deliverstatus in('발송준비', '배송준비', '배송중', '배송완료', '배송실패'));
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.



desc tbl_cart;
desc tbl_order;

select * 
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = '테이블명';

select * 
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = '테이블명';



select * from TBL_CART;
select * from TBL_PRODUCT;
select * from TBL_PRODUCT_IMAGEFILE;

desc tbl_cart;

insert into tbl_cart
values(2203311221, 'admin', 9791197381010, 2, sysdate);

select * from tbl_cart;

desc tbl_product;
select * from tbl_product where pk_pro_num = '9791197381010';

select * from 

commit;

select * from tbl_product_imagefile;



select * from tabs;
select * from tbl_writer;
select * from tbl_product;
select * from tbl_spec;
select * from tbl_category;
select * from tbl_product_imagefile;

desc tbl_product;           
-- fk_cate_num, pk_pro_num, pro_name, pro_imgfile_name, pro_price, pro_saleprice, point_rate, 
-- publisher, pro_publish_date, pro_inputdate, pro_qty, pro_sales, pro_viewcnt, 
-- fk_wr_code, pro_index, pro_content, pro_size, pro_bindtype, pro_pages
desc tbl_spec;              -- pk_spec_num, fk_cate_num, spec_size, ck_bindtype, spec_pages;
desc TBL_PRODUCT_IMAGEFILE; -- fk_pro_num, pro_imgfile_name2
desc tbl_writer;            -- PK_WR_CODE, WR_NAME, WR_INFO
desc tbl_category;          -- pk_cate_num, cate_name
--------------------------------------------------------------------------------
-- 기본정보  상품명 이미지파일 판매가 
-- 품목정보  상품명 저자명(저자코드) 출판사 출간일
--          카테고리명(카테고리 코드) 상품코드 정가
--          목차 책소개 저자소개
-- 기타     입고일(New) 재고량,판매량(품절 표시) 조회수(Best 20)
--------------------------------------------------------------------------------
-- 우선 추가이미지/스펙 테이블 빼고
SELECT  A.pro_name, A.pro_imgfile_name, A.pro_price,
        A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date,
        A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice,
        A.pro_index, A.pro_content, B.wr_info,
        A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt        
FROM tbl_product A
LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code
LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num
WHERE pk_pro_num = '9791196045999';

--
String sql = "SELECT  A.pro_name, A.pro_imgfile_name, A.pro_price,\n"+
"        A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date,\n"+
"        A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice,\n"+
"        A.pro_index, A.pro_content, B.wr_info,\n"+
"        A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt        \n"+
"FROM tbl_product A\n"+
"LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code\n"+
"LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num\n"+
"WHERE pk_pro_num = '9791196045999'";

desc tbl_order;
desc tbl_member;
select * from tabs;

select * from TBL_PRODUCT_IMAGEFILE;

desc tbl_spec;

drop table tbl_spec purge;
-- Table TBL_SPEC이(가) 삭제되었습니다.

commit;

desc tbl_product;

--------------------------------------------------------

SELECT  A.pro_name, A.pro_imgfile_name, A.pro_price,
        A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date,
        A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice,
        A.pro_index, A.pro_content, B.wr_info,
        A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt        
FROM tbl_product A
LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code
LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num
WHERE pk_pro_num = '9791196045999';


desc tbl_writer;
select * from tbl_writer;


