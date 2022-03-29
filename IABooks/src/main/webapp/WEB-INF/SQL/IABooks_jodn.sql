select *
from TBL_MEMBER;
-- 회원
CREATE TABLE "TBL_MEMBER" (
	"PK_USERID"         VARCHAR2(20)  NOT NULL, -- 회원아이디
	"PWD"               VARCHAR2(200) NOT NULL, -- 비밀번호
	"NAME"              VARCHAR2(25)  NOT NULL, -- 이름
	"ADDRESS"           VARCHAR2(100) NOT NULL, -- 기본주소
	"DETAILADDRESS"     VARCHAR2(100) NOT NULL, -- 상세주소
	"NUMBER"            VARCHAR2(20)  NULL,     -- 일반전화
	"UQ_PHONE"          VARCHAR2(200) NOT NULL, -- 휴대전화
	"UQ_EMAIL"          VARCHAR2(200) NOT NULL, -- 이메일
	"POINT"             NUMBER(5)     DEFAULT 0,-- 적립금
	"COUPON"            NUMBER(5)     NULL,     -- 쿠폰
	"REGISTERDAY"       DATE          NULL,     -- 가입일자
	"LASTPWDCHANGEDATE" DATE          NOT NULL, -- 마지막암호변경날짜시각
	"POSTCODE"          VARCHAR2(20)  NOT NULL, -- 우편번호
	"BIRTHDAY"          VARCHAR2(20)  NULL,     -- 생년월일
	"CK_GENDER"         CHAR          NULL,     -- 성별
	"CK_STATUS"         CHAR          DEFAULT 1, -- 회원탈퇴유무
	"CK_U_STATUS"       CHAR          DEFAULT 0  -- 휴면상태
);

commit;

DROP TABLE tbl_member PURGE;

select *
from tab;

purge recyclebin;


DROP INDEX PK_TBL_MEMBER; 

-- 회원
alter table TBL_MEMBER
	add
		constraint PK_TBL_MEMBER -- 회원 기본키
		primary key (
			PK_USERID -- 회원아이디
		);

-- 회원
ALTER TABLE tbl_member
	ADD
		CONSTRAINT UK_tbl_member -- 회원 유니크 제약
		UNIQUE (
			uq_email, -- 이메일
			uq_phone -- 휴대전화
		);

-- 회원
ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_gender -- 성별체크
		CHECK (ck_gender in('1','2'));

-- 회원
ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_status -- 회원탈퇴유무
		CHECK (ck_status in('0','1'));

-- 회원
ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_u_status -- 휴면 유무 체크
		CHECK (ck_u_status in('0','1'));
        
        
        
-------------------------------------------

-- 로그인기록
ALTER TABLE tbl_loginhistory
	ADD
		CONSTRAINT FK_tbl_mbr_TO_tbl_lgnhstr -- 회원 -> 로그인기록
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);
        
 ------------------ 오더 =--------------------------
 
 -- 주문
ALTER TABLE TBL_ORDER
	ADD
		CONSTRAINT CK_TBL_ORDER_TOTALPRICE -- 주문총액체크
		CHECK (ODR_TOTALPRICE > 0);

-- 주문
ALTER TABLE TBL_ORDER
	ADD
		CONSTRAINT CK_TBL_ORDER_TOTALPOINT -- 주문총포인트체크
		CHECK (ODR_TOTALPOINT >= 0);



select *
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_ORDER';
  
  
select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
from user_constraints A JOIN user_cons_columns B
ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
where A.table_name = 'TBL_ORDER';
        