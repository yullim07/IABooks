show user;
-- USER이(가) "SEMIORAUSER3"입니다.

select *
from tabs;


CREATE TABLE TBL_ORDER (
	"pk_odrcode"     VARCHAR2(25)  NOT NULL, -- 주문코드
	"fk_userid"      VARCHAR2(20)  NOT NULL, -- 회원아이디
	"odr_totalprice" NUMBER(10)    NOT NULL, -- 주문총액
	"odr_totalpoint" NUMBER        DEFAULT 0, -- 주문총포인트
	"odr_date"       DATE          DEFAULT sysdate, -- 주문일자
	"rv_name"        VARCHAR2(8)   NOT NULL, -- 이름
	"rv_zipcode"     VARCHAR2(5)   NOT NULL, -- 우편번호
	"rv_addr1"       VARCHAR2(100) NOT NULL, -- 기본주소
	"rv_addr2"       VARCHAR2(100) NOT NULL, -- 상세주소
	"rv_phone"       VARCHAR2(200) NOT NULL, -- 휴대전화
	"rv_email"       VARCHAR2(200) NOT NULL, -- 이메일
	"del_msg"        VARCHAR2(50)  NULL      -- 배송메시지
);

CREATE TABLE "TBL_LOGINHISTORY" (
	"fk_userid" VARCHAR2(20) NOT NULL, -- 회원아이디
	"logindate" DATE         DEFAULT sysdate, -- 로그인날짜시각
	"clientip"  VARCHAR2(15) NOT NULL  -- 접속IP주소
);

CREATE TABLE "TBL_CART" (
	"pk_cartno"        NUMBER       NOT NULL, -- 장바구니번호
	"fk_userid"        VARCHAR2(20) NOT NULL, -- 회원아이디
	"pk_pro_num"       NUMBER       NULL,     -- 국제표준도서번호
	"ck_odr_qty"       NUMBER(4)    DEFAULT 0, -- 주문량
	"ck_cart_register" DATE         DEFAULT sysdate -- 입력일자
);

SELECT UPPER(COLUMN) FROM TBL_CART;



