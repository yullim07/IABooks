select *
from tbl_member;

-- 회원
create table tbl_member (
    pk_userid         varchar2(20)  not null, -- 회원아이디
	pwd               varchar2(200) not null, -- 비밀번호
    mname              varchar2(25)  not null, -- 이름
	address           varchar2(100) not null, -- 기본주소
	detailaddress     varchar2(100) not null, -- 상세주소
    
	tel               varchar2(20)  null,     -- 일반전화
	uq_phone          varchar2(200) not null, -- 휴대전화
	uq_email          varchar2(200) not null, -- 이메일
	mileage           number        default 0,-- 적립금
	coupon            number        null,     -- 쿠폰
	registerday       date          default sysdate,     -- 가입일자
	lastpwdchangedate date          default sysdate, -- 마지막암호변경날짜시각
	postcode          varchar2(20)  not null, -- 우편번호
	birthday          varchar2(20)  null,     -- 생년월일
	ck_gender         char          null,     -- 성별
	ck_status         char          default 1, -- 회원탈퇴유무
	ck_u_status       char          default 0  -- 휴면상태
);

ALTER TABLE tbl_member MODIFY tel INVISIBLE;
ALTER TABLE tbl_member MODIFY uq_phone INVISIBLE;
ALTER TABLE tbl_member MODIFY uq_email INVISIBLE;
ALTER TABLE tbl_member MODIFY mileage INVISIBLE;
ALTER TABLE tbl_member MODIFY registerday INVISIBLE;
ALTER TABLE tbl_member MODIFY postcode INVISIBLE;
ALTER TABLE tbl_member MODIFY birthday INVISIBLE;
ALTER TABLE tbl_member MODIFY ck_gender INVISIBLE;
ALTER TABLE tbl_member MODIFY ck_status INVISIBLE;
ALTER TABLE tbl_member MODIFY ck_u_status INVISIBLE;


alter table tbl_member add extraaddress varchar2(100) not null; 
alter table tbl_member modify ck_gender varchar2(5);
alter table tbl_member modify ck_status varchar2(5);
alter table tbl_member modify ck_u_status varchar2(5);




drop table TBL_MEMBER purge;

commit;

-- DROP TABLE TBL_MEMBER PURGE;

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
        