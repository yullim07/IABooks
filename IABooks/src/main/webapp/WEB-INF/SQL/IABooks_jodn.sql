select *
from tbl_member;

alter table tbl_user_coupon_status add coupon number default 0;

select *
from tbl_coupon
where pk_coupon_id = 267740114188324;

select *
from TBL_USER_COUPON_STATUS

delete from TBL_USER_COUPON_STATUS where pk_userid = 'deokno'
commit;

-- 중복쿠폰발행 조회 

select PK_COUPON_ID
from tbl_coupon
where PK_COUPON_ID = 213



--------쿠폰조회 -------
select DISTINCT PK_COUPON_ID,CNAME,CPRICE,CDATE,CSTARTDATE,CENDDATE,CMINPRICE,CPSTATUS,user_cp_status, coupon, m.pk_userid
from 
(
select PK_COUPON_ID, CNAME,CPRICE,CDATE,CSTARTDATE,CENDDATE,CMINPRICE,CPSTATUS
from tbl_coupon
) C
cross join
(
select PK_userid, coupon
from tbl_member
where PK_userid = 'admin'
) M
CROSS JOIN
(
select pk_userid, coupon_id, user_cp_status
from tbl_user_coupon_status
where PK_userid = 'admin' and user_cp_status = '1' and coupon_id = '?'
) U

-- 개인쿠폰조회
select rno, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS , pk_userid, user_cp_status   
from
(
select row_number() over(order by M.pk_userid desc) as rno ,
M.pk_userid, C.pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, U.user_cp_status    
from tbl_member M
join tbl_user_coupon_status U
on M.pk_userid = U.pk_userid
join tbl_coupon C
on C.pk_coupon_id = U.coupon_id

)V
where pk_userid='deokno' and CPSTATUS='1'


-- 쿠폰 기간지나면 삭제할 셀렉트 가져오기
select  CENDDATE,  pk_userid , pk_coupon_id  
from
(
select row_number() over(order by M.pk_userid desc) as rno ,
M.pk_userid, C.pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, U.user_cp_status    
from tbl_member M
join tbl_user_coupon_status U
on M.pk_userid = U.pk_userid
join tbl_coupon C
on C.pk_coupon_id = U.coupon_id

)V
where pk_userid='deokno' and CPSTATUS='1'

-- 아이디값으로 개인상세페이지 보여주기
select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, birthday
from tbl_member 
 where pk_userid = 'deokno' 



select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, birthday, to_char(sysdate, 'yyyy')- substr(birthday,1,4)+1 as age
from tbl_member
 where pk_userid = 'moonby'

select  to_char(registerday, 'yyyy-mm-dd') as registerday
from tbl_member
 where pk_userid = 'moonby'

select count(*)
from tbl_user_coupon_status
where pk_userid = 'deokno';


select ceil(count(*)/5) 
from tbl_user_coupon_status 
where pk_userid = 'deokno';

-- 쿠폰 페이징 처리
select rno, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS , pk_userid, user_cp_status   
from
(
select rownum as rno ,
M.pk_userid, C.pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, U.user_cp_status    
from tbl_member M
join tbl_user_coupon_status U
on M.pk_userid = U.fk_userid
join tbl_coupon C
on C.pk_coupon_id = U.coupon_id
order by C.cenddate
)V
where pk_userid='deokno' and CPSTATUS='1' and rno between 11 and 15;

-- 페이징 처리된 쿠폰 리스트 보여주기 
 select rno, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS , pk_userid, user_cp_status 
 from 
 ( 
    select rownum as rno ,
    pk_userid, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, user_cp_status 
    from (
         select M.pk_userid, C.pk_coupon_id, C.cname, C.cprice, C.cdate, C.cstartdate, C.CENDDATE, C.CMINPRICE, C.CPSTATUS, U.user_cp_status 
         from tbl_member M 
         join tbl_user_coupon_status U 
         on M.pk_userid = U.fk_userid 
         join tbl_coupon C 
         on C.pk_coupon_id = U.coupon_id 
         where pk_userid='admin' and CPSTATUS='1'   
         order by C.cenddate
         )V 
     )v2
 where rno between 11 and 15;

delete from tbl_coupon

delete from TBL_USER_COUPON_STATUS
commit;
-- 쿠폰 유효기간 만료 시 값 변경 


update TBL_USER_COUPON_STATUS 
set USER_CP_STATUS = '1' 
where fk_userid = 'deokno';

UPDATE TBL_USER_COUPON_STATUS  U
    SET USER_CP_STATUS = (
    select U.user_cp_status  
    from
    (
    select row_number() over(order by M.pk_userid desc) as rno ,
    M.pk_userid, C.pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, U.user_cp_status    
    from tbl_member M
    join tbl_user_coupon_status U
    on M.pk_userid = U.pk_userid
    join tbl_coupon C
    on C.pk_coupon_id = U.coupon_id
    where M.pk_userid = 'deokno' and cenddate < sysdate 
    )V
);


select *
from tbl_user_coupon_status;

insert into tbl_user_coupon_status (PK_USERID,COUPON_ID)
values('admin','978379227619298');

insert into tbl_coupon(PK_COUPON_ID, CNAME, CPRICE,  CSTARTDATE, CENDDATE, CMINPRICE) 
	                   values('12312', '배송비무료쿠폰', '2599',  '23123', '123123','123123');

UPDATE tbl_user_coupon_status SET user_cp_status='1' 
commit;

select * 
 from tbl_user_coupon_status 
 
 
 select ceil(count(*)/5) 
 from tbl_member 
 where pk_userid != 'admin' 
 and mname like '%'|| '덕' ||'%'
 
 select pk_userid, mname, uq_email, ck_gender 
 from 
 (  
 select rownum as rno, pk_userid, mname, uq_email, ck_gender 
 from 
 ( 
 select pk_userid, mname, uq_email, ck_gender 
 from tbl_member 
 where pk_userid != 'admin' 
 and mname like '%'|| '덕' ||'%' 
order by registerday desc
 ) V 
 ) T 
 where rno between 1 and 5  
 

-- 유저 쿠폰 등록시 중복확인 

select coupon_id 
 from tbl_user_coupon_status 
 where coupon_id = 226231131867645 and PK_USERID = 'deokno' 

select coupon_id
from tbl_user_coupon_status
where coupon_id = 735374052996278 and PK_USERID = 'admin'




-- 탈퇴해제 
update tbl_member set ck_status = '1' where pk_userid = 'deokno';

update tbl_member set tel = '031-555-1234' where PK_userid = 'admin';

delete from tbl_member where Pk_userid = 'deokno';
commit;

delete from tbl_loginhistory where fk_userid='deokno';
delete from tbl_member where Pk_userid = 'deokno';
commit;

delete from tbl_loginhistory where fk_userid='admin';
delete from tbl_member where Pk_userid = 'admin';
commit;

update tbl_member set  mname = '덕노'
, lastpwdchangedate= sysdate
where pk_userid = 'deokno' ;


select *
from tbl_loginhistory;





-- 쿠폰 테이블 생성
create table tbl_coupon (
    pk_coupon_id    varchar2(20)  primary key,  -- 쿠폰아이디
    cname           varchar2(50) not null,      -- 쿠폰이름 
    cprice          varchar2(20)  not null,     -- 할인가격
    cdate           date   default sysdate,     -- 쿠폰발급일
    cstartdate      date   not null,            -- 쿠폰사용가능일
    cenddate        date   not null             -- 쿠폰사용가능일
    );

-- 쿠폰하고 회원하고 연결하는 테이블 생성
create table tbl_user_coupon_status ( 
    pk_userid varchar2(20)  not null, -- 회원아이디
    coupon_id varchar2(20)  not null -- 쿠폰아이디
)
alter table tbl_user_coupon_status add user_cp_status varchar2(20) default '1'; -- 쿠폰사용여부 1 또는 0

-- 회원
create table tbl_member (
    pk_userid         varchar2(20)  not null,       -- 회원아이디
	pwd               varchar2(200) not null,       -- 비밀번호
    mname             varchar2(25)  not null,       -- 이름
	address           varchar2(100) not null,       -- 기본주소
	detailaddress     varchar2(100) null,           -- 상세주소
    extraaddress      varchar2(100) null,
	tel               varchar2(20)  null,           -- 일반전화
	uq_phone          varchar2(200) not null,       -- 휴대전화
	uq_email          varchar2(200) not null,       -- 이메일
	mileage           number        default 0,      -- 적립금
	coupon            number        null,           -- 쿠폰
	registerday       date          default sysdate,     -- 가입일자
	lastpwdchangedate date          default sysdate,        -- 마지막암호변경날짜시각
	postcode          varchar2(20)  not null,           -- 우편번호
	birthday          varchar2(20)  null,                -- 생년월일
	ck_gender         varchar2(20)  null,               -- 성별
	ck_status         varchar2(20)  default 1,          -- 회원탈퇴유무
	ck_u_status       varchar2(20)  default 0            -- 휴면상태
);

select *
from tbl_member


SELECT pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, 
 birthday, registerday, pwdchangegap, tel, ck_u_status, ck_status ,
nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap 
 FROM 
 ( 
 select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, ck_u_status, ck_status 
    , birthday , tel, to_char(registerday, 'yyyy-mm-dd') AS registerday 
    , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap 
 from tbl_member
 where ck_status = 1 and pk_userid = 'deokno' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
 ) M 
 CROSS JOIN 
 (
 select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap 
 from tbl_loginhistory 
 where fk_userid = 'deokno' 
 ) H

UPDATE tbl_member SET ck_status = 1 WHERE pk_userid = 'deokno'

UPDATE tbl_member SET ck_u_status=1 
 WHERE pk_userid = 'deokno' 

UPDATE tbl_member SET ck_u_status = 0 , ck_status = 1 WHERE pk_userid = 'deokno'

commit

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



CREATE TABLE TBL_LOGINHISTORY (
	fk_userid VARCHAR2(20) NOT NULL, -- 회원아이디
	logindate DATE         DEFAULT sysdate, -- 로그인날짜시각
	clientip  VARCHAR2(15) NOT NULL  -- 접속IP주소
);

-- 회원탈퇴 날짜 저장 
ALTER TABLE tbl_member ADD DeleteDay date NULL; 

select *
from tbl_mileage

select *
from tbl_order

update tbl_mileage
set fk_ordercode = 'by0225' 

delete from tbl_mileage

select pk_userid , ODR_DATE
from tbl_mileage
join tbl_member
on pk_userid = fk_userid
join tbl_order
on pk_odrcode = fk_odrcode
where pk_userid = 'moonby'

drop table test_mileage purge;

delete test_mileage

-- 마일리지 테이블 조회
select *
from test_mileage

select *
from tbl_order

-- 마일리지가 적립되어질 때
INSERT INTO test_mileage (USERID, INFOMILEAGE, USEDDATE, status, odr_code )
VALUES ('moonby', 5000, sysdate, '0', 'by0225' );

INSERT INTO test_mileage (USERID, INFOMILEAGE, USEDDATE, status, odr_code )
VALUES ('moonby', 2000, sysdate, '0', 'by0225' );

-- 조건이 확정되어서 적립이 완전히 되어질때 
update test_mileage set status = '1'
where userid = 'moonby' and odr_code = 'by0225'


-- 마일리지가 사용될 때
INSERT INTO test_mileage (USERID, INFOMILEAGE, USEDDATE, status, odr_code )
VALUES ('moonby', -1000, sysdate, '1', 'by0225' );


-- 누군가의 마일리지 내역검색
select *
from test_mileage
where userid = 'moonby' 

-- 마일리지 사용내역
select *
from test_mileage
where userid = 'moonby' and INFOMILEAGE<0

-- 마일리지 적립내역
select *
from test_mileage
where userid = 'moonby' and INFOMILEAGE>0

-- 총적립금
select sum(INFOMILEAGE) as all_mg
from test_mileage
where userid = 'moonby'

-- 사용할 수 있는 적립금 
select sum(INFOMILEAGE) as all_mg
from test_mileage
where userid = 'moonby' and status = '1'

--미가용적립금
select nvl(sum(INFOMILEAGE), 0) as 미가용적립금
from test_mileage
where userid = 'moonby' and status = '0'

-- 물건 환불 시 
INSERT INTO test_mileage (USERID, INFOMILEAGE, USEDDATE, status, odr_code )
VALUES ('moonby', -2000, sysdate, '0', 'by0225' );

-- 환불예정적립금
select nvl(sum(INFOMILEAGE), 0) as 환불예정적립금
from test_mileage
where userid = 'moonby' and odr_code = 'by0225' and status='0'


select M.pk_userid, C.pk_coupon_id, CENDDATE, user_cp_status 
from tbl_member M  
 join tbl_user_coupon_status U 
 on M.pk_userid = U.fk_userid  
 join tbl_coupon C 
 on C.pk_coupon_id = U.coupon_id  
 where pk_userid='admin' and user_cp_status='1' 
 AND TO_DATE(C.CENDDATE,'YYYY-MM-DD') < TO_DATE( TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD'); 
 
 select M.pk_userid, C.pk_coupon_id
from tbl_member M  
 join tbl_user_coupon_status U 
 on M.pk_userid = U.fk_userid  
 join tbl_coupon C 
 on C.pk_coupon_id = U.coupon_id  
 where pk_userid='admin' and user_cp_status='1' 
 AND TO_DATE(C.CENDDATE,'YYYY-MM-DD') < TO_DATE( TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD');
 
 select *
 from tbl_orderdetail
 
 
 
 
 select M.pk_userid, C.pk_coupon_id, CENDDATE, user_cp_status 
from tbl_member M  
 join tbl_user_coupon_status U 
 on M.pk_userid = U.fk_userid  
 join tbl_coupon C 
 on C.pk_coupon_id = U.coupon_id  
 where pk_userid='deokno' and user_cp_status='1' 

select *
from tbl_order

-- 주문배송 단계 조회 
select count(*)
from tbl_orderdetail D
join tbl_order O
on D.fk_odrcode = O.pk_odrcode
join tbl_member M
on M.pk_userid = O.fk_userid
where D.CK_DELIVERSTATUS = '1' and M.pk_userid='admin';


-- 주문 금액 조회
select sum(odr_price)
from tbl_orderdetail D
join tbl_order O
on D.fk_odrcode = O.pk_odrcode
join tbl_member M
on M.pk_userid = O.fk_userid
where M.pk_userid='admin';

-- 주문 횟수 조회 
select count(*)
from tbl_orderdetail D
join tbl_order O
on D.fk_odrcode = O.pk_odrcode
join tbl_member M
on M.pk_userid = O.fk_userid
where M.pk_userid='admin';

-- 적립금 조회 
select sum(mileageInfo)
from tbl_mileage I
join tbl_member M
on M.pk_userid = I.fk_userid
join tbl_order O
on I.fk_odrcode = O.pk_odrcode
where m.pk_userid = 'admin'


DISTINCT 
select *
from tbl_orderdetail D
join tbl_order O
on D.fk_odrcode = O.pk_odrcode
join tbl_member M
on M.pk_userid = O.fk_userid
where M.pk_userid='admin';




select *
from tbl_orderdetail D
join tbl_order O
on D.fk_odrcode = O.pk_odrcode
join tbl_member M
on M.pk_userid = O.fk_userid
join tbl_mileage I
on I.fk_userid = m.pk_userid

where M.pk_userid='admin' and 




select *
from tbl_mileage


select rownum, PK_COUPON_ID, CNAME, CPRICE, CDATE, CSTARTDATE, CENDDATE, CPSTATUS, CMINPRICE 
from tbl_coupon
order by CENDDATE desc;


from tbl_
        