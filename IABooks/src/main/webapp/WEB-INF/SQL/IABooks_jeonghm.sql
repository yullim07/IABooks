show user;


-- FAQ 분류
CREATE TABLE tbl_faq_category (
	pk_faq_c_num NUMBER       NOT NULL, -- FAQ 번호
	faq_c_name   VARCHAR2(20) NULL      -- FAQ 이름
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

DROP TABLE "TBL_LOGINHISTORY" CASCADE CONSTRAINTS;
DROP TABLE "TBL_MEMBER" CASCADE CONSTRAINTS;
commit;

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

ALTER TABLE tbl_comment modify (isdelete VARCHAR2(10) DEFAULT '0');
ALTER TABLE tbl_faq_board modify (isdelete VARCHAR2(10) DEFAULT '0');
ALTER TABLE tbl_review_board modify (isdelete VARCHAR2(10) DEFAULT '0');
ALTER TABLE tbl_faq_board modify (isdelete VARCHAR2(10) DEFAULT '0');


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


select rownum AS rno, pk_faq_c_num, faq_c_name
from tbl_faq_category;

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


    select A.pk_faq_board_num, B.faq_c_name, A.faq_title, A.faq_writer
    from tbl_faq_board A JOIN tbl_faq_category B
    ON A.fk_faq_c_num = B.pk_faq_c_num
    where isdelete = 0
    order by pk_faq_board_num desc;


    String sql = "select rownum AS rno, A.pk_faq_board_num, B.faq_c_name, A.faq_title, A.faq_writer\n"+
"    from tbl_faq_board A JOIN tbl_faq_category B\n"+
"    ON A.fk_faq_c_num = B.pk_faq_c_num\n"+
"    order by rno desc;";

