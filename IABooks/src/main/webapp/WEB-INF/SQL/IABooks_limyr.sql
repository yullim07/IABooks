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


SELECT
A.pro_name, A.pro_imgfile_name, A.pro_saleprice,
A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
A.fk_cate_num, C.cate_name, A.pro_bindtype, A.pro_pages, A.pro_size,  "
A.pk_pro_num, A.pro_price, "
A.pro_index, A.pro_content, B.wr_info, "
A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
FROM tbl_product A
LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code "
LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num "
WHERE pk_pro_num = '9791189652067';

desc tbl_member;
desc tbl_product;
desc tbl_cart;
select * from tbl_cart;


select  A.pk_cartno, A.fk_userid, A.pk_pro_num, A.ck_odr_qty, A.ck_cart_register,
        B.pro_name, B.pro_saleprice,
        nvl(C.pro_imgfile_name2, A.pk_pro_num)
from tbl_cart A
LEFT OUTER JOIN tbl_product B ON A.pk_pro_num = B.pk_pro_num
LEFT OUTER JOIN tbl_product_imagefile C ON A.pk_pro_num = C.fk_pro_num
where pk_cartno = '2203311221';

desc tbl_product_imagefile;
select * from tbl_product_imagefile;



-- pk_cartno, fk_userid, pk_pro_num, ck_odr_qty, ck_cart_register

insert into tbl_cart(pk_cartno, fk_userid, pk_pro_num, ck_odr_qty, ck_cart_register)
values(2204031751, 'leess', 9791189652067, 3, sysdate);

select * from tbl_cart;

delete from tbl_cart where pk_cartno = 2204031751;

commit;

-- 장바구니 수량 변경
desc tbl_cart;

update tbl_cart
set CK_ODR_QTY = 7
where PK_CARTNO = 2204031751;

select * from tbl_cart;
commit;


-- 장바구니 추가
select pk_cartno
from tbl_cart
where status = 1 and ;
update tbl_cart
set PK_CARTNO = .
FK_USERID
PK_PRO_NUM
CK_ODR_QTY
CK_CART_REGISTER

-- 장바구니 테이블 변수 추가(c_status)

ALTER TABLE tbl_cart ADD c_status NUMBER(1) default 1 NOT NULL;
-- Table TBL_CART이(가) 변경되었습니다.

commit;
-- 커밋 완료.

desc tbl_product;
desc tbl_cart;
ALTER TABLE tbl_cart
	ADD
		CONSTRAINT CK_tbl_cart_c_status -- 장바구니 비움 여부
		CHECK (c_status in (0, 1));
-- Table TBL_CART이(가) 변경되었습니다.

commit;
-- 커밋 완료.

-- 로그인한 사용자(loginuser)만 장바구니에 담는다.
SELECT  A.pk_cartno, A.fk_userid, A.pk_pro_num,
        NVL(B.pro_imgfile_name, B.Pk_Pro_Num), B.pro_price, B.pro_saleprice,
        A.ck_odr_qty, A.c_status        
FROM tbl_cart A JOIN tbl_product B
ON A.pk_pro_num = B.PK_PRO_NUM
WHERE A.c_status = 1 AND A.fk_userid = 'leess'
ORDER BY A.pk_cartno desc;

select * from tbl_cart;

-- 주문자 이름 뽑아오기
SELECT  A.pk_cartno, A.fk_userid, A.pk_pro_num,
        B.pro_name, NVL(B.pro_imgfile_name, B.pk_pro_num), B.pro_price, B.pro_saleprice,
        A.ck_odr_qty, A.c_status   
FROM tbl_cart A JOIN tbl_product B
ON A.pk_pro_num = B.PK_PRO_NUM
WHERE A.c_status = 1 AND A.fk_userid = 'leess'
ORDER BY A.pk_cartno desc;

desc tbl_product;
desc tbl_cart;

--------------------------------------------------------------------------------



-- tbl_cart에서는 pk_pro_num이 number 타입
-- 제품테이블은 PK_PRO_NUM이 VARCHAR2니까 모두 문자열로 변경

-- 컬럼의 속성 변경하기
ALTER TABLE tbl_order ALTER COLUMN PK_PRO_NUM VARCHAR2(20) NOT NULL;

select * from tbl_cart;
delete from tbl_cart;
desc tbl_cart;

alter table tbl_cart drop column PK_PRO_NUM;
alter table tbl_cart PK_PRO_NUM VARCHAR2(20);
alter table tbl_cart MODIFY (PK_PRO_NUM NOT NULL);

-- 장바구니(PK_CARTNO) 대신 시퀀스 적용하기
INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791197296932', 1, sysdate, 1);

select * from tbl_cart;
s

-- 시퀀스 생성 --
CREATE SEQUENCE seq_cartno
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

select * from user_sequences;

select seq_cartno.currval from dual;

desc tbl_cart;
INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791197296932', )


----------------- 시퀀스 추가 및 PK_PRO_NUM의 데이터 타입 변경 완료 -----------------



-- ProductDAO의 addCart의 첫번째 SQL문
SELECT pk_cartno
FROM tbl_cart
WHERE
c_status = 1 AND fk_userid = 'leess' AND pk_pro_num = '9791189652067';

select * from tbl_cart;

-- ProductDAO의 addCart의 두번째 SQL문(if문 - 어떤 제품을 추가로 장바구니에 넣고자 하는 경우)
UPDATE tbl_cart
SET ck_odr_qty = ck_odr_qty + 2
WHERE pk_cartno = '2204031751';
-- 1 행 이(가) 업데이트되었습니다.

select * from tbl_cart;
desc tbl_cart;

commit;

-- ProductDAO의 addCart의 세번째 SQL문(else문 - 장바구니에 없던 어떤 제품을 추가로 장바구니에 넣고자 하는 경우)
INSERT INTO tbl_cart(pk_cartno, fk_userid, pk_pro_num, ck_odr_qty, c_status)
VALUES(seq_cartno.nextval, 'admin', '9791197296932', 2, DEFAULT);

select * from tbl_cart; commit; desc tbl_cart;
INSERT INTO tbl_cart(pk_cartno, fk_userid, pk_pro_num, ck_odr_qty, c_status)
VALUES(seq_cartno.nextval, ?, ?, ?, DEFAULT);


desc tbl_product; desc tbl_cart;
select * from tbl_product;

-- getCartList
SELECT A.PK_CARTNO, 
FROM tbl_cart A LEFT OUTER JOIN tbl_product B
ON A.PK_PRO_NUM = B.PK_PRO_NUM
WHERE A.C_STATUS = 1 AND A.FK_USERID = ?


-- 제약조건 조회 확인 
select constraint_name, constraint_type, table_name from user_constraints;
where table_name = 'TBL_PRODUCT';

select *
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = 'tbl_product';


ALTER TABLE tbl_writer
	ADD
		CONSTRAINT PK_tbl_writer -- 저자 기본키
		PRIMARY KEY (
			pk_wr_code -- 저자코드
		);

ALTER TABLE tbl_cart rename constraints
SYS_C007479 TO FK_TBL_CART_USERID;

desc tbl_member;
-- 장바구니 제약조건 추가
ALTER TABLE tbl_cart
	ADD
		CONSTRAINT FK_member_to_cart
		FOREIGN KEY (
			fk_userid -- 저자코드
		)
		REFERENCES tbl_member ( -- 저자
			pk_userid -- 저자코드
		);
        
        desc tbl_cart;
        
-- getCartList SQL문

SELECT  A.PK_CARTNO, A.FK_USERID, A.PK_PRO_NUM, 
        B.PRO_NAME, B.FK_CATE_NUM, 
        B.PRO_IMGFILE_NAME, B.PRO_PRICE, B.PRO_SALEPRICE, 
        A.CK_ODR_QTY, A.C_STATUS
FROM tbl_cart A LEFT OUTER JOIN tbl_product B
ON A.PK_PRO_NUM = B.PK_PRO_NUM
WHERE A.C_STATUS = 1 AND A.FK_USERID = 'leess';

desc tbl_cart;


--------------------------------------------------------------------------------




-- 2022년 04월 04일 23시 54분 카트 확인용

select * from tbl_cart;
select pk_pro_num from tbl_product;
desc tbl_cart;

INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791190604062', 3, sysdate, 1);
-- 제약조건 때문에 못 만든다

select last_number from user_sequences where sequence_name = 'seq_cartno';

select constraint_name, constraint_type, table_name from user_constraints
where table_name = 'TBL_CART';

select * from user_constraints
where table_name = 'TBL_CART'; 

-- 1. 현재 장바구니 테이블에 이순신의 정보가 들어있음.
-- 2. insert into에 pk_cartno를 seq_cartno.NEXTVAL이라고 쓰려고 했더니 무결성 제약을 위배한다고 뜸
-- 같은 사용자가 여러번 살 수도 있으니 제약조건 UK_TBL_CART 제약조건 삭제하겠다.

alter table tbl_cart
drop constraints UK_TBL_CART;
-- Table TBL_CART이(가) 변경되었습니다.

INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791190604062', 1, sysdate, 1);
-- 1 행 이(가) 삽입되었습니다.

select * from tbl_cart A left outer join tbl_product B
on A.pk_pro_num = B.pk_pro_num
where A.c_status = 1 AND A.fk_userid = 'leess';

------------------

-- 220405

select * from tbl_cart where fk_userid = 'leess';
select * from tbl_product where pk_pro_num = '9791190604062'; -- 커피 한 잔 값으로 독립출판 책 디자인
select * from tbl_product where pk_pro_num = '9791197296932'; -- 명화로 읽는 전쟁의 세계사

------------
-- 장바구니 이미지 포함 출력
SELECT  A.pk_cartno, A.fk_userid, A.pk_pro_num
        , B.pro_name, B.fk_cate_num, C.cate_name
        , B.pro_imgfile_name, B.pro_price, B.pro_saleprice
		, A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS totalPrice
        , A.ck_odr_qty, A.c_status
FROM tbl_cart A LEFT OUTER JOIN tbl_product B
                ON A.pk_pro_num = B.pk_pro_num
                LEFT OUTER JOIN tbl_category C
                ON B.fk_cate_num = C.pk_cate_num
WHERE A.c_status = 1 AND A.fk_userid = 'leess';


desc tbl_cart; PK_PRO_NUM
desc tbl_product; FK_CATE_NUM
desc tbl_category; PK_CATE_NUM

commit;

--------------------------------------------------------------------------------

-- 2022년 04월 06일, 20220406

select * from tbl_cart;

select pk_pro_num from tbl_product


INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791190604062', 1, sysdate, 1);

INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9788993767766', 2, sysdate, 1);

INSERT INTO
tbl_cart(PK_CARTNO, FK_USERID, PK_PRO_NUM, CK_ODR_QTY, CK_CART_REGISTER, C_STATUS)
VALUES (seq_cartno.NEXTVAL, 'leess', '9791160542080', 3, sysdate, 1);


