show user;
/*
-- FAQ 분류
CREATE TABLE tbl_faq_category (
	pk_faq_c_num NUMBER       NOT NULL, -- FAQ 번호
	faq_c_name   VARCHAR2(20) NULL,      -- FAQ 이름
    faq_c_ename  VARCHAR2(20)
);

-- 댓글
CREATE TABLE tbl_comment (
	pk_cmt_num   NUMBER        NOT NULL, -- 댓글번호
	fk_userid    VARCHAR2(20)  NOT NULL, -- 회원아이디
	fk_qna_num   NUMBER        NOT NULL, -- 문의번호
	cmt_name     VARCHAR2(10)  NOT NULL, -- 댓글이름
	cmt_passwd   VARCHAR2(20)  NOT NULL, -- 댓글비밀번호
	cmt_contents VARCHAR2(200) NOT NULL, -- 댓글내용
	cmt_date     DATE default sysdate, -- 작성일자
    isdelete     VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);


-- 상품Q&A 게시판
CREATE TABLE tbl_qna_board (
	pk_qna_num    NUMBER         NOT NULL, -- 문의번호
	fk_userid     VARCHAR2(20)   NOT NULL, -- 회원아이디
	fk_pnum       NUMBER         NOT NULL, -- 국제표준도서번호
	qna_title     VARCHAR2(20)   NOT NULL, -- 제목
	qna_isanswer  VARCHAR2(5)    NULL,     -- 답변유무
	qna_readcount NUMBER         DEFAULT 0, -- 조회수
	qna_date      DATE           DEFAULT sysdate, -- 작성일자
	qna_contents  VARCHAR2(1000) NOT NULL, -- 게시글 내용
	qna_passwd    VARCHAR2(20)   NOT NULL, -- 글비밀번호
	qna_issecret  VARCHAR2(5)    NULL,      -- 비밀유무
    isdelete     VARCHAR2(10)    NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);

-- 도서후기 게시판
CREATE TABLE tbl_review_board (
	pk_rnum      NUMBER         NOT NULL, -- 후기번호
	fk_pnum      NUMBER         NOT NULL, -- 국제표준도서번호
	fk_userid    VARCHAR2(20)   NOT NULL, -- 회원아이디
	re_title     VARCHAR2(20)   NOT NULL, -- 게시글 제목
	re_date      DATE           DEFAULT sysdate, -- 작성일자
	re_readcount NUMBER         DEFAULT 0, -- 조회수
	re_grade     NUMBER         NOT NULL, -- 평점
	re_contents  VARCHAR2(1000) NOT NULL, -- 게시글 내용
	re_passwd    VARCHAR2(20)   NOT NULL, -- 글비밀번호
	re_writer    VARCHAR2(10)   NOT NULL,  -- 작성자
    isdelete     VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);

-- FAQ 게시판(관리자만 입력가능)
CREATE TABLE tbl_faq_board (
	pk_faq_board_num NUMBER         NOT NULL, -- 문의번호
	fk_userid        VARCHAR2(20)   NOT NULL, -- 회원아이디
	fk_faq_c_num     NUMBER         NOT NULL, -- FAQ 번호
	faq_title        VARCHAR2(40)   NOT NULL, -- 제목
	faq_writer       VARCHAR2(10)   NOT NULL, -- 작성자
	faq_contents     VARCHAR2(1000) NOT NULL,  -- 게시글 내용
    isdelete         VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);

-------------------------------------------------------------------------------------------------------

alter table tbl_comment add isdelete VARCHAR2(10) NOT NULL;
alter table tbl_qna_board add isdelete VARCHAR2(10) NOT NULL;
alter table tbl_review_board add isdelete VARCHAR2(10) NOT NULL;
alter table tbl_faq_board add isdelete VARCHAR2(10) NOT NULL;

commit;

select *
from tbl_qna_board;

select *
from tabs;

rollback;

SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

--이메일, 암호, 
-------------------------------------------------------------------------------------------------------------

-- 제약조건 조회
SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_FAQ_CATEGORY';

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_COMMENT';

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_QNA_BOARD';

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_REVIEW_BOARD';

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_FAQ_BOARD';

  select *
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_FAQ_CATEGORY';
  
  select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_COMMENT';
  
  select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_QNA_BOARD';
  
  select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_REVIEW_BOARD';
  
    select B.CONSTRAINT_NAME, a.constraint_type ,b.column_name, a.search_condition
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_FAQ_BOARD';
  
  commit;


-- 상품Q&A 게시판
CREATE TABLE tbl_qna_board (
	pk_qna_num    NUMBER         NOT NULL, -- 문의번호
	fk_userid     VARCHAR2(20)   NOT NULL, -- 회원아이디
	fk_pnum       NUMBER         NOT NULL, -- 국제표준도서번호
	qna_title     VARCHAR2(20)   NOT NULL, -- 제목
	qna_isanswer  VARCHAR2(5)    NULL,     -- 답변유무
	qna_readcount NUMBER         DEFAULT 0, -- 조회수
	qna_date      DATE           DEFAULT sysdate, -- 작성일자
	qna_contents  VARCHAR2(1000) NOT NULL, -- 게시글 내용
	qna_passwd    VARCHAR2(20)   NOT NULL, -- 글비밀번호
	qna_issecret  VARCHAR2(5)    NULL      -- 비밀유무
);

insert into tbl_qna_board(pk_qna_num, fk_userid, fk_pnum, qna_title, qna_isanswer, qna_contents, qna_passwd, qna_issecret)
values(seq_qna_board.nextval, '111', '001','222', '1', '반갑습니다.', '1234', '1');
-----------------------------------------
create table test_board (
userid VARCHAR2(20) NOT NULL
, contents VARCHAR2(100) NOT NULL
);

insert into test_board(userid, contents)
values('111', '222');

String sql = "insert into test_board(userid, contents)\n"+
"values('111', '222');";

select *
from test_board;

String sql = "select *\n"+
"from test_board;";

commit;

insert into tbl_faq_category values('1', '전체');
insert into tbl_qna_board values('2', '회원');
insert into tbl_faq_category values('3', '상품');
insert into tbl_faq_category values('4', '주문/배송');
insert into tbl_faq_category values('5', '반품/교환');
insert into tbl_faq_category values('6', '제휴');

select *
from tbl_faq_category;

commit;

select * from user_sequences;

-- TABLE tbl_comment modify (isdelete VARCHAR2(10) DEFAULT '0');


CREATE TABLE tbl_faq_board (
	pk_faq_board_num NUMBER         NOT NULL, -- 문의번호
	fk_userid        VARCHAR2(20)   NOT NULL, -- 회원아이디
	fk_faq_c_num     NUMBER         NOT NULL, -- FAQ 번호
	faq_title        VARCHAR2(40)   NOT NULL, -- 제목
	faq_writer       VARCHAR2(10)   NOT NULL, -- 작성자
	faq_contents     VARCHAR2(1000) NOT NULL,  -- 게시글 내용
    isdelete         VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);

pk_faq_c_num NUMBER       NOT NULL, -- FAQ 번호
	faq_c_name


select *
from tbl_faq_category;

UPDATE tbl_faq_category SET faq_c_ename='all' WHERE pk_faq_c_num=1;
UPDATE tbl_faq_category SET faq_c_ename='member' WHERE pk_faq_c_num=2;
UPDATE tbl_faq_category SET faq_c_ename='product' WHERE pk_faq_c_num=3;
UPDATE tbl_faq_category SET faq_c_ename='return' WHERE pk_faq_c_num=4;
UPDATE tbl_faq_category SET faq_c_ename='order' WHERE pk_faq_c_num=5;
UPDATE tbl_faq_category SET faq_c_ename='promotion' WHERE pk_faq_c_num=6;

commit;

select *
from tbl_faq_board;

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 3, '독립출판물이란 무엇인가요?', '인디펍'
, '일반적으로 재입고 가능한 도서의 경우 7일 정도 시간이 소요됩니다.
   아래의 방법으로 재입고 가능 여부를 확인하실 수 있습니다.
   상품 문의 남기기
   이메일 문의 CS@indiepub.kr 
    카카오톡 채널 문의
    [절판] 아이콘이 표시된 도서는 절판이 확인된 도서로 재입고가 어려운 점 참고 바랍니다.');
    
insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 5, '반품은 어떻게 하나요?', '인디펍'
, '난 2번 글이다.');

commit;

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 4, '주문한 상품은 언제 받을 수 있나요?', '인디펍'
, '난 3번 글이다.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 4, '현금영수증 발행신청은 어디서 하나요?', '인디펍'
, '난 4번 글이다.');


insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 4, '배송비는 얼마인가요?', '인디펍'
, '난 5번 글이다.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 4, '비회원 주문조회는 어떻게 하나요?', '인디펍'
, '난 6번 글이다.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 4, '해외 배송이 가능한가요?', '인디펍'
, '난 7번 글이다.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 5, '교환은 어떻게 하나요?', '인디펍'
, '난 8번 글이다.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', 3, '품절된 도서입니다. 재입고는 언제 되나요?', '인디펍'
, '난 9번 글이다.');

    select A.pk_faq_board_num, B.faq_c_name, A.faq_title, A.faq_writer
    from tbl_faq_board A JOIN tbl_faq_category B
    ON A.fk_faq_c_num = B.pk_faq_c_num
    where isdelete = 0
    order by pk_faq_board_num desc;


    select pk_faq_board_num, faq_c_name, faq_title, faq_writer
    from tbl_faq_board A JOIN tbl_faq_category B
    ON A.fk_faq_c_num = B.pk_faq_c_num
    where isdelete = 0
    order by pk_faq_board_num desc;



select A.pk_faq_board_num, A.fk_faq_c_num, A.faq_title, A.faq_writer  
from tbl_faq_board A 
JOIN tbl_faq_category B  
ON A.fk_faq_c_num = B.pk_faq_c_num  
where isdelete = 0 and b.faq_c_ename = 'product';

COMMIT;


insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)
values(SEQ_FAQ_BOARD.nextval, 'indiepub', ?, ?, ?, ?);

String sql = "insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents)\n"+
"values(SEQ_FAQ_BOARD.nextval, 'indiepub', ?, ?, ?, ?);";

select *
from tbl_faq_board;


commit;

--Review 게시판 목록 보기
select  pk_rnum, P.pro_name, P.pro_imgfile_name, re_title, M.mname, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_readcount, fk_userid , re_grade
from tbl_member M
JOIN tbl_review_board R  ON M.pk_userid = R.fk_userid
JOIN tbl_product P ON R.fk_pnum = P.pk_pro_num
where isdelete = 0
order by pk_rnum desc;

CREATE TABLE tbl_review_board (
	pk_rnum      NUMBER         NOT NULL, -- 후기번호
	fk_pnum      NUMBER         NOT NULL, -- 국제표준도서번호
	fk_userid    VARCHAR2(20)   NOT NULL, -- 회원아이디
	re_title     VARCHAR2(20)   NOT NULL, -- 게시글 제목
	re_date      DATE           DEFAULT sysdate, -- 작성일자
	re_readcount NUMBER         DEFAULT 0, -- 조회수
	re_grade     NUMBER         NOT NULL, -- 평점
	re_contents  VARCHAR2(1000) NOT NULL, -- 게시글 내용
	re_passwd    VARCHAR2(20)   NOT NULL, -- 글비밀번호
	re_writer    VARCHAR2(10)   NOT NULL,  -- 작성자
    isdelete     VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);

insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_writer, re_title, re_contents, re_passwd ,isdelete, re_grade)
values(1, '9791197381010', 'admin', '관리자', '정말 재밌어요','나의 식사에는 감정이 있습니다 너무 재밌게 봤어요','qwer1234$', 0, 4);

insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_writer, re_title, re_contents, re_passwd ,isdelete, re_grade)
values(2, '9791197381010', 'admin', '관리자', '정말 재밌어요','나의 식사에는 감정이 있습니다 너무 재밌게 봤어요','qwer1234$', 0, 4);

insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_writer, re_title, re_contents, re_passwd ,isdelete, re_grade)
values(3, '9791197381010', 'admin', '관리자', '정말 재밌어요','나의 식사에는 감정이 있습니다 너무 재밌게 봤어요','qwer1234$', 0, 4);

commit;

update tbl_review_board set fk_pnum='123';

commit;

select * from user_sequences


select ceil( count(*)/10 )
from tbl_review_board;

commit;

select pk_rnum, fk_pnum, fk_userid, re_writer, re_title, re_contents, re_passwd ,isdelete, re_grade
from tbl_review_board

select pk_rnum, re_title, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_readcount, re_grade
from tbl_review_board

*/
/*

update tbl_review_board set re_writer='인디펍';

commit;

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_member';

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents )
values(1, 'admin', 3, '반갑습니다!', '작작', '제발 글이 잘써졌으면 좋겠어요.');

insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents )
values(2, 'admin', 2, '에러가 하나 뜨면 너무 무섭습니다.', '작작', '해결이 안되면 그것만 잡고 있거든요.');

--
commit;

select *
from user_sequences;


select *
from tbl_product

commit;
 
select *
from tbl_review_board

desc TBL_FAQ_CATEGORY;
desc TBL_FAQ_BOARD;
desc TBL_MEMBER;

select a.fk_faq_c_num, b.faq_c_name, a.faq_title, a.faq_writer
from TBL_FAQ_BOARD A JOIN TBL_FAQ_CATEGORY B
ON A.FK_FAQ_C_NUM = B.PK_FAQ_C_NUM
JOIN TBL_MEMBER C 
ON A.FK_USERID = C.PK_USERID
where isdelete = 0
order by pk_faq_board_num desc;


commit;

select pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents, isdelete
from tbl_faq_board
where pk_faq_board_num = 20;

desc tbl_faq_board;

*/

select *
from tbl_product;

update tbl_faq_board set faq_title = ?, faq_contents= ?, fk_faq_c_num = ?
where pk_faq_board_num = 6
String sql = "update tbl_faq_board set faq_title = ?, faq_contents= ?, fk_faq_c_num = ?\n"+
"where pk_faq_board_num = 6";



select *
from tbl_faq_board

select *
from tbl_faq_board
where fk_faq_c_num = 3;


-----------------------------------------------------------
-- 선생님 피드백
select prevnum, prevtitle,currentnum, currenttitle, nextnum, nexttitle 
from
(
select   
         lag(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as prevnum
       , lag(faq_title, 1) over(order by pk_faq_board_num desc) as prevtitle
         -- 이전(미래)
       , pk_faq_board_num as currentnum
       , faq_title as currenttitle 
       , lead(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as nextnum
       , lead(faq_title, 1) over(order by pk_faq_board_num desc) as nexttitle  
         -- 다음(과거)
from tbl_faq_board
) v

-- 기준이 같아야함
-- default는 뷰단에서 잡아줘라
---
5
4
3
2
1
--

     1  2  3 페이지
     5  3  1
     4  2
-----------------------------------------------------------

/*

desc TBL_FAQ_BOARD


String sql = "select currentnum, currenttitle, prevnum, prevtitle, nextnum, nexttitle\n"+
"from\n"+
"(\n"+
"select   pk_faq_board_num as currentnum\n"+
"         , faq_title as currenttitle\n"+
"         , lead(pk_faq_board_num, 1, 0) over(order by pk_faq_board_num desc) as nextnum\n"+
"         , lead(faq_title, 1, '다음글이 없습니다') over(order by faq_title desc) as nexttitle\n"+
"         , lag(pk_faq_board_num, 1, 0) over(order by pk_faq_board_num desc) as prevnum\n"+
"         , lag(faq_title, 1, '이전글이 없습니다') over(order by faq_title desc) as prevtitle\n"+
"from tbl_faq_board\n"+
") v\n"+
"where currentnum = 3;";

delete 
from TBL_FAQ_BOARD

-- 시퀀스 값 초기화
drop sequence SEQ_FAQ_BOARD

  create sequence SEQ_FAQ_BOARD
  start with 1    -- 첫번쨰 출발은 1 부터 한다.
  increment by 1  -- 증가치는 1이다. 1씩 증가한다.
  maxvalue 10000      -- 최대값이 5이다.
  minvalue 1      -- 최소값이 2이다.
  cycle           -- 반복을 한다.
  nocache;

select last_number from user_sequences where sequence_name = 'SEQ_FAQ_BOARD'

alter sequence SEQ_FAQ_BOARD increment by -1;

select SEQ_FAQ_BOARD.nextval from dual;

select *
from user_sequences

select *
from tbl_faq_board
order by pk_faq_board_num;

-- 끝

commit;

select *
from tbl_product

desc tbl_review_board
desc tbl_product
desc tbl_member



select pk_rnum, pro_name, pro_imgfile_name, re_title, mname
       , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, re_readcount, fk_userid , re_grade
from tbl_review_board R JOIN tbl_member M 
ON R.fk_userid = M.pk_userid 
JOIN tbl_product P
ON P = P.pk_pro_num = R.fk_pnum
where R.isdelete = 0;


select pk_rnum, R.re_title,
       M.mname AS mname, to_char(R.re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, re_readcount, R.fk_userid , R.re_grade
from tbl_review_board R JOIN tbl_member M ON R.fk_userid = M.pk_userid 


-- 리뷰 쿼리문 
SELECT pk_rnum, pro_name, p_img_name, re_title, mname, re_date, fk_userid, re_grade, cate_name
FROM   
(   
    SELECT rownum as rno, pk_rnum, pro_name, p_img_name, re_title, mname, re_date, fk_userid, re_grade, cate_name
    FROM
    (    
        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS p_img_name, R.re_title AS re_title, M.mname AS mname
               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name
        from tbl_member M
        JOIN tbl_review_board R
        ON  M.PK_USERID = R.FK_USERID
        JOIN tbl_product P
        ON R.fk_pnum = P.pk_pro_num
        JOIN TBL_CATEGORY C
        ON P.fk_cate_num = C.pk_cate_num
        WHERE isdelete = 0
    ) V
) T
where rno between 1 and 10

-- 리뷰쿼리문 수정
SELECT pk_rnum, pro_name, p_img_name, re_title, mname, re_date, fk_userid, re_grade, cate_name, rownum
FROM   
(   
    SELECT rownum as rno, pk_rnum, pro_name, p_img_name, re_title, mname, re_date, fk_userid, re_grade, cate_name
    FROM
    (    
        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS p_img_name, R.re_title AS re_title, M.mname AS mname
               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name
        from tbl_member M
        JOIN tbl_review_board R
        ON  M.PK_USERID = R.FK_USERID
        JOIN tbl_product P
        ON R.fk_pnum = P.pk_pro_num
        JOIN TBL_CATEGORY C
        ON P.fk_cate_num = C.pk_cate_num
        WHERE isdelete = 0
        order by re_date desc
    ) V
) T
where rownum between 1 and 10

------------------------------------------




select PK_RNUM, FK_PNUM, FK_USERID, RE_TITLE, RE_DATE, RE_GRADE, RE_CONTENTS, RE_PASSWD, RE_WRITER, isdelete, P.pro_name, P.pro_imgfile_name
from tbl_review_board R JOIN tbl_product P
ON R.FK_PNUM = P.pk_pro_num


String sql = "select prevnum, prevtitle,currentnum, currenttitle, nextnum, nexttitle \n"+
"from\n"+
"(\n"+
"select   \n"+
"         lag(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as prevnum\n"+
"       , lag(faq_title, 1) over(order by pk_faq_board_num desc) as prevtitle\n"+
"         -- 이전(미래)\n"+
"       , pk_faq_board_num as currentnum\n"+
"       , faq_title as currenttitle \n"+
"       , lead(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as nextnum\n"+
"       , lead(faq_title, 1) over(order by pk_faq_board_num desc) as nexttitle  \n"+
"         -- 다음(과거)\n"+
"from tbl_faq_board\n"+
") v";



select ceil( count(*)/5 )
			from tbl_review_board A JOIN tbl_product B 
			ON A.FK_PNUM = B.PK_PRO_NUM
			JOIN tbl_member C ON A.FK_USERID = C.PK_USERID
			where pk_pro_num = '9791190259088';


String sql = "\n"+
"select ceil( count(*)/5 )\n"+
"			from tbl_review_board A JOIN tbl_product B \n"+
"			ON A.FK_PNUM = B.PK_PRO_NUM\n"+
"			JOIN tbl_member C ON A.FK_USERID = C.PK_USERID\n"+
"			where fk_pnum = '9791190259088';";

select * from user_sequences;

select *
from tbl_review_board

ceil( count(*)/10 )

select COUNT(CASE WHEN F.fk_userid='admin' THEN 1 END) AS faqCnt
     , COUNT(CASE WHEN R.fk_userid='admin' THEN 1 END) AS revCnt
     , COUNT(CASE WHEN Q.fk_userid='admin' THEN 1 END) AS qnaCnt
from tbl_faq_board F 
JOIN tbl_review_board R
ON F.fk_userid = R.fk_userid
JOIN tbl_qna_board Q
ON R.fk_userid = Q.fk_userid;


select ceil( (revCnt + qnaCnt) / 10 ) AS myCnt
from ( select COUNT(CASE WHEN fk_userid='gorush34' THEN 1 END) AS revCnt from  tbl_review_board ) R
   , ( select COUNT(CASE WHEN fk_userid='gorush34' THEN 1 END) AS qnaCnt from  tbl_qna_board ) Q

select revCnt, qnaCnt
from ( select COUNT(CASE WHEN fk_userid='gorush34' THEN 1 END) AS revCnt, re_title, re_contents from  tbl_review_board where re_title like '%'||'세계'||'%' ) R
   , ( select COUNT(CASE WHEN fk_userid='gorush34' THEN 1 END) AS qnaCnt, qna_title, qna_contents from  tbl_qna_board where qna_title like '%'||'세계'||'%' ) Q



select R.pk_rnum AS pk_rnum, R.fk_pnum AS fk_pnum, R.re_title AS re_title
     , to_char(R.re_date, 'yyyy-mm-dd') AS re_date, R.re_grade AS re_grade
     , Q.pk_qna_num AS pk_qna_num, Q.qna_title AS qna_title
     , to_char(Q.qna_date, 'yyyy-mm-dd') AS qna_date
from tbl_review_board R
LEFT OUTER JOIN tbl_qna_board Q
ON R.fk_userid = Q.fk_userid
WHERE R.fk_userid = 'gorush34' OR Q.fk_userid = 'gorush34' AND R.isdelete = 0 AND Q.isdelete = 0;

select *
from tbl_review_board R
LEFT OUTER JOIN tbl_qna_board Q
ON R.fk_userid = Q.fk_userid
WHERE R.fk_userid = 'gorush34' OR Q.fk_userid = 'gorush34'

select pk_rnum, fk_pnum, re_title, re_date, re_grade, pk_qna_num, qna_title, qna_date
from 
(
select pk_rnum AS pk_rnum, fk_pnum AS fk_pnum, re_title AS re_title, to_char(re_date, 'yyyy-mm-dd') AS re_date, re_grade AS re_grade
from tbl_review_board
where fk_userid = 'gorush34'
) R
FULL JOIN
(
select pk_qna_num AS pk_qna_num, qna_title AS qna_title, to_char(qna_date, 'yyyy-mm-dd') AS qna_date
from tbl_qna_board
where fk_userid = 'gorush34'
) Q
ON R.fk_userid = Q.fk_userid



select *
from tbl_review_board R
FULL OUTER JOIN tbl_qna_board Q
ON R.fk_userid = Q.fk_userid
WHERE R.fk_userid = 'gorush34' 


create table tbl_jtest1 (
jo      VARCHAR2(10)  
,zo      VARCHAR2(10)  
);

create table tbl_jtest2 (
jojo      VARCHAR2(10)    
,jo        VARCHAR2(10)
);

insert into tbl_jtest1 (zo) values('조');
insert into tbl_jtest2 (jojo) values('조조');


select *
from tbl_jtest1 A
FULL OUTER JOIN tbl_jtest2 B
ON A.jo = B.jo

select *
from tbl_review_board A
FULL OUTER JOIN tbl_qna_board B
ON A.fk_userid = B.fk_userid
where re_title is null

select B.pk_qna_num, B.qna_title, B.qna_date
from tbl_review_board A
FULL OUTER JOIN tbl_qna_board B
ON A.fk_userid = B.fk_userid
where A.pk_rnum is null


select A.pk_rnum, A.re_title, A.re_date, A.re_grade
from tbl_review_board A
FULL OUTER JOIN tbl_qna_board B
ON A.fk_userid = B.fk_userid
where B.pk_qna_num is null


select *
from tbl_review_board
where fk_userid = 'gorush34'

select *
from tbl_qna_board

SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade
FROM
(
    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade
    from 
        (
        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date
        from tbl_qna_board A
        FULL OUTER JOIN tbl_review_board B
        ON A.qna_title = B.re_title
        where A.fk_userid = 'gorush34'
        ) Q
    FULL OUTER JOIN
        (
        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade
        from tbl_qna_board A
        FULL OUTER JOIN tbl_review_board B
        ON A.qna_title = B.re_title
        where B.fk_userid = 'gorush34'
        ) R
    ON Q.qna_title = R.re_title
) V
where rno between 1 and 10
and re_title like '%' || '세계' || '%' or qna_title like '%' || '세계' || '%';

select *
from tbl_member;

desc tbl_cart

*/

------ 220411


/* 관심상품 */
CREATE TABLE tbl_wishlist (
	pk_wnum NUMBER NOT NULL, /* 관심상품번호 */
	fk_userid VARCHAR2(20), /* 회원아이디 */
	fk_pnum VARCHAR2(20), /* 국제표준도서번호 */
	wdate DATE, /* 입력일자 */
    w_status NUMBER(1) NOT NULL /* */
);

commit;

DESC tbl_wishlist;
desc tbl_cart;

---

  create sequence SEQ_WISHLIST
  start with 1    -- 첫번쨰 출발은 1 부터 한다.
  increment by 1  -- 증가치는 1이다. 1씩 증가한다.
  maxvalue 10000      -- 최대값이 5이다.
  minvalue 1      -- 최소값이 2이다.
  cycle           -- 반복을 한다.
  nocache;


update tbl_wishlist set wdate= sysdate where pk_wnum = 1;

insert into tbl_wishlist(PK_WNUM, FK_USERID, FK_PNUM, W_STATUS)
values(SEQ_WISHLIST.nextval, 'gorush34', '9791196418335', 1);

insert into tbl_wishlist(PK_WNUM, FK_USERID, FK_PNUM, W_STATUS)
values(SEQ_WISHLIST.nextval, 'gorush34', '9791196832827', 1);

insert into tbl_wishlist(PK_WNUM, FK_USERID, FK_PNUM, W_STATUS)
values(SEQ_WISHLIST.nextval, 'gorush34', '9788991216983', 1);

SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num
     , B.pro_name, B.fk_cate_num, C.cate_name 
     , B.pro_imgfile_name, B.pro_price, B.pro_saleprice
     , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS partPrice
FROM tbl_cart A LEFT OUTER JOIN tbl_product B 
ON A.fk_pro_num = B.pk_pro_num 
LEFT OUTER JOIN tbl_category C 
ON B.fk_cate_num = C.pk_cate_num 
WHERE A.c_status = 1 AND A.fk_userid = 'gorush34'

SELECT A.PK_WNUM, A.FK_USERID, A.FK_PNUM
     , B.pro_name, B.fk_cate_num, C.cate_name 
     , B.pro_imgfile_name, B.pro_price, B.pro_saleprice, A.w_status
FROM tbl_wishlist A LEFT OUTER JOIN tbl_product B 
ON A.fk_pnum = B.pk_pro_num 
LEFT OUTER JOIN tbl_category C 
ON B.fk_cate_num = C.pk_cate_num 
WHERE A.w_status = 1 AND A.fk_userid = 'gorush34'

select *
from tbl_wishlist


select *
from tbl_cart
where fk_userid = 'gorush34';


select fk_pnum
from tbl_wishlist join tbl_product 
on fk_pnum = pk_pro_num
where fk_userid = 'gorush34' and pk_wnum = 1 

select pro_qty 
from tbl_product 
where pk_pro_num = '9791196418335'

9791196418335


select count(*)
from tbl_review_board



SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade
FROM
(
    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade
    from 
        (
        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date
        from tbl_qna_board A
        FULL OUTER JOIN tbl_review_board B
        ON A.qna_title = B.re_title
        where A.fk_userid is not null and B.re_title is null 
        ) Q
    FULL OUTER JOIN
        (
        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade
        from tbl_qna_board A
        FULL OUTER JOIN tbl_review_board B
        ON A.qna_title = B.re_title
        where B.fk_userid is not null and A.qna_title is null
        ) R
    ON Q.qna_title = R.re_title
) V