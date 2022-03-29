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