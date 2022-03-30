select *
from tabs;

-----== ** Primary Key 추가 ** ==-----
-- ** FAQ 분류
ALTER TABLE TBL_FAQ_CATEGORY
	ADD
		CONSTRAINT PK_tbl_faq_category -- FAQ 분류 기본키
		PRIMARY KEY (
			pk_faq_c_num -- FAQ 번호
		);
--Table TBL_FAQ_CATEGORY이(가) 변경되었습니다.

-- ** 댓글
ALTER TABLE tbl_comment
	ADD
		CONSTRAINT PK_tbl_comment -- 댓글 기본키
		PRIMARY KEY (
			pk_cmt_num -- 댓글번호
		);
--Table TBL_COMMENT이(가) 변경되었습니다.

-- ** 상품Q&A 게시판
ALTER TABLE tbl_qna_board
	ADD
		CONSTRAINT PK_tbl_qna_board -- 상품Q&A 게시판 기본키
		PRIMARY KEY (
			pk_qna_num -- 문의번호
		);
--Table TBL_QNA_BOARD이(가) 변경되었습니다.

-- ** 도서후기 게시판
ALTER TABLE tbl_review_board
	ADD
		CONSTRAINT PK_tbl_review_board -- 도서후기 게시판 기본키
		PRIMARY KEY (
			pk_rnum -- 후기번호
		);
--Table TBL_REVIEW_BOARD이(가) 변경되었습니다.

-- ** FAQ 게시판(관리자만 입력가능)
ALTER TABLE tbl_faq_board
	ADD
		CONSTRAINT PK_tbl_faq_board -- FAQ 게시판(관리자만 입력가능) 기본키
		PRIMARY KEY (
			pk_faq_board_num -- 문의번호
		);
--Table TBL_FAQ_BOARD이(가) 변경되었습니다.

------------------------------------------------------//


-----== ** Foreign Key 추가 ** ==-----
-- ** 댓글
ALTER TABLE tbl_comment
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_comment -- 회원 -> 댓글
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);
--Table TBL_COMMENT이(가) 변경되었습니다.


-- ** 댓글
ALTER TABLE tbl_comment
	ADD
		CONSTRAINT FK_tbl_qn_board_TO_tbl_cmnt -- 상품Q&A 게시판 -> 댓글
		FOREIGN KEY (
			fk_qna_num -- 문의번호
		)
		REFERENCES tbl_qna_board ( -- 상품Q&A 게시판
			pk_qna_num -- 문의번호
		);
--Table TBL_COMMENT이(가) 변경되었습니다.

-- ** 상품Q&A 게시판
ALTER TABLE tbl_qna_board
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_qna_board -- 회원 -> 상품Q&A 게시판
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);
--Table TBL_QNA_BOARD이(가) 변경되었습니다.

-- ** 상품Q&A 게시판
ALTER TABLE tbl_qna_board
	ADD
		CONSTRAINT FK_tbl_prdct_TO_tbl_qn_brd -- 제품 -> 상품Q&A 게시판
		FOREIGN KEY (
			fk_pnum -- 국제표준도서번호
		)
		REFERENCES tbl_product ( -- 제품
			pk_pro_num -- 국제표준도서번호
		);
--Table TBL_QNA_BOARD이(가) 변경되었습니다.


-- ** 도서후기 게시판
ALTER TABLE tbl_review_board
	ADD
		CONSTRAINT FK_tbl_prdct_TO_tbl_rvw_brd -- 제품 -> 도서후기 게시판
		FOREIGN KEY (
			fk_pnum -- 국제표준도서번호
		)
		REFERENCES tbl_product ( -- 제품
			pk_pro_num -- 국제표준도서번호
		);
--Table TBL_REVIEW_BOARD이(가) 변경되었습니다.

-- ** 도서후기 게시판
ALTER TABLE tbl_review_board
	ADD
		CONSTRAINT FK_tbl_mbr_TO_tbl_rvw_brd -- 회원 -> 도서후기 게시판
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);
--Table TBL_REVIEW_BOARD이(가) 변경되었습니다.


-- ** FAQ 게시판(관리자만 입력가능)
ALTER TABLE tbl_faq_board
	ADD
		CONSTRAINT FK_tbl_fq_ctgr_TO_tbl_brd -- FAQ 분류 -> FAQ 게시판(관리자만 입력가능)
		FOREIGN KEY (
			fk_faq_c_num -- FAQ 번호
		)
		REFERENCES tbl_faq_category ( -- FAQ 분류
			pk_faq_c_num -- FAQ 번호
		);
--Table TBL_FAQ_BOARD이(가) 변경되었습니다.

-- ** FAQ 게시판(관리자만 입력가능)
ALTER TABLE tbl_faq_board
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_faq_board -- 회원 -> FAQ 게시판(관리자만 입력가능)
		FOREIGN KEY (
			fk_userid -- 회원아이디
		)
		REFERENCES TBL_MEMBER ( -- 회원
			pk_userid -- 회원아이디
		);
--Table TBL_FAQ_BOARD이(가) 변경되었습니다.

------------------------------------------------------//
select *
from tabs;

select *
from TBL_MEMBER;

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_CART';

select *
  from user_constraints A JOIN user_cons_columns B
  ON A.constraint_name = B.constraint_name -- 제약조건 이름이 같고
  where A.table_name = 'TBL_ORDERDETAIL';
  
  
  
  
  ------------------------------------
  --- 시퀀스 생성 ---

create sequence seq_qna_board
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 
--Sequence SEQ_QNA_BOARD이(가) 생성되었습니다.

  
create sequence seq_review_board
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SEQ_REVIEW_BOARD이(가) 생성되었습니다.


create sequence seq_faq_board
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SEQ_FAQ_BOARD이(가) 생성되었습니다.


SELECT * FROM USER_SEQUENCES

select *
from tbl_faq_category
order by SEQ_FAQ_CATEGORY asc;

select *
from TBL_MEMBER;

select B.boardno, B.subject, M.name, 
        to_char(writeday,'yyyy-mm-dd hh24:mi:ss'), 
        B.viewcount       ,
        nvl(C.commentcnt,0)  
from TBL_QNA_BOARD B 
JOIN TBL_MEMBER M  
ON B.fk_userid = M.pk_userid  
LEFT JOIN
    (select fk_boardno, count(*) as COMMENTCNT            
    from jdbc_comment            
    group by fk_boardno) C  
ON B.boardno = C.fk_boardno  
order by 1 desc 

select *
from TBL_qna_board;

select pk_qna_num,  qna_title, fk_userid, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount
from tbl_qna_board B JOIN tbl_member M
ON B.fk_userid = M.pk_userid
order by pk_qna_num desc;


select *
from tabs;
--------------------------------
alter table tbl_review_board add uccurl VARCHAR2(1000) NULL;
alter table tbl_review_board add uccurl VARCHAR2(1000) NULL;

ALTER TABLE tbl_review_board MODIFY re_title varchar2(100);
--Table TBL_REVIEW_BOARD이(가) 변경되었습니다.
ALTER TABLE TBL_QNA_BOARD MODIFY qna_title varchar2(100);
--Table TBL_QNA_BOARD이(가) 변경되었습니다.


insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_title, re_grade, re_contents, re_passwd, re_writer)
values(SEQ_REVIEW_BOARD.nextval, '222', 'admin', '후기입니다', 5,'자바의 정석을 읽었습니다. 추천합니다','qwer1234$','이재희');

insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_title, re_grade, re_contents, re_passwd, re_writer)
values(SEQ_REVIEW_BOARD.nextval, '333', 'admin', '제목이 길게 써질까요!!??', 5,'오늘은 화요일 내일은 수요일 모레는 목요일입니다. 추천합니다','qwer1234$','김재희');

insert into tbl_review_board (pk_rnum, fk_pnum, fk_userid, re_title, re_grade, re_contents, re_passwd, re_writer)
values(SEQ_REVIEW_BOARD.nextval, '444', 'admin', '제목이 길게 써질까요!!?? 얼마나 길게 써질까요 우다다다다', 4,'오늘은 화요일 내일은 수요일 모레는 목요일입니다. 추천합니다','qwer1234$','박재희');

commit;
--커밋 완료.

select *
from tbl_review_board;


select A.pk_faq_board_num, B.faq_c_name, A.faq_title, A.faq_writer  
from tbl_faq_board A 
LEFT JOIN tbl_faq_category B  
ON A.fk_faq_c_num = B.pk_faq_c_num  
where isdelete = 0  
order by pk_faq_board_num desc;


select pk_rnum,  fk_pnum, re_title, re_writer, re_readcount , M.mname
from tbl_review_board B 
JOIN tbl_member M 
ON B.fk_userid = M.pk_userid 
where isdelete = 0
order by pk_rnum desc 


String sql = "select pk_rnum,  fk_pnum, re_title, re_writer, re_readcount , M.mname\n"+
"from tbl_review_board B \n"+
"JOIN tbl_member M \n"+
"ON B.fk_userid = M.pk_userid \n"+
"where isdelete = 0\n"+
"order by pk_rnum desc ";


select *
from tbl_qna_board;
commit;

select *
from tbl_product;


insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title, qna_contents, qna_passwd ,isdelete)
values(SEQ_QNA_BOARD.nextval, '111', 'admin', '리틀 어피치 상품 문의 드립니다','리틀어피치 재고는 언제 입고 될까요? 재고예정일 답변 부탁드립니다','qwer1234$', 0);

insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title, qna_contents, qna_passwd ,isdelete)
values(SEQ_QNA_BOARD.nextval, '22', 'admin', '라이언 상품 문의 드립니다','라이언 재고는 언제 입고 될까요? 재고예정일 답변 부탁드립니다','qwer1234$', 0);

insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title, qna_contents, qna_passwd ,isdelete)
values(SEQ_QNA_BOARD.nextval, '33', 'admin', '카카오프렌즈 대량구매 문의 드립니다','라이언, 리틀어피치 각 100개씩 대량구매 문의드립니다.  답변 부탁드립니다','qwer1234$', 0);

insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title, qna_contents, qna_passwd ,isdelete)
values(SEQ_QNA_BOARD.nextval, '9791197381010', 'admin', '책 재입고문의','나의 식사에는 감정이 있습니다 책 재입고 문의드립니다','qwer1234$', 0);

commit;

select *
from tbl_qna_board;


-- 이클립스 추가용
select pk_rnum,  fk_pnum, re_title, re_writer, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_grade , M.mname
from tbl_review_board B 
JOIN tbl_member M 
ON B.fk_userid = M.pk_userid 
where isdelete = 0
order by pk_rnum desc



select pk_qna_num,  fk_pnum, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret
from tbl_qna_board Q
JOIN tbl_member M 
ON Q.fk_userid = M.pk_userid 
where isdelete = 0
order by pk_qna_num desc

--qna 게시판 목록 보기
select  pk_qna_num, P.pro_name, P.pro_imgfile_name, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret
from tbl_member M
JOIN tbl_qna_board Q  ON M.pk_userid = Q.fk_userid
JOIN tbl_product P ON Q.fk_pnum = P.pk_pro_num
where isdelete = 0
order by pk_qna_num desc;


select  pk_qna_num, P.pro_name, P.pro_imgfile_name, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret
from tbl_member M
JOIN tbl_qna_board Q  
ON M.pk_userid = Q.fk_userid
JOIN tbl_product P 
ON Q.fk_pnum = P.pk_pro_num
where isdelete = 0
order by pk_qna_num desc;

String sql = "select  pk_qna_num, P.pro_name, P.pro_imgfile_name, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret\n"+
"from tbl_member M\n"+
"JOIN tbl_qna_board Q  \n"+
"ON M.pk_userid = Q.fk_userid\n"+
"JOIN tbl_product P \n"+
"ON Q.fk_pnum = P.pk_pro_num\n"+
"where isdelete = 0\n"+
"order by pk_qna_num desc";



String sql = "\n"+
"select  pk_qna_num, P.pro_name, P.pro_imgfile_name, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret\n"+
"from tbl_member M\n"+
"JOIN tbl_qna_board Q  ON M.pk_userid = Q.fk_userid\n"+
"JOIN tbl_product P ON Q.fk_pnum = P.pk_pro_num\n"+
"where isdelete = 0\n"+
"order by pk_qna_num desc";

select pk_rnum, re_title, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_readcount, re_grade
from tbl_review_board

select *
from tbl_review_board;

select pk_qna_num
from tbl_qna_board;

alter table tbl_qna_board modify qna_issecret default 0;
--Table TBL_QNA_BOARD이(가) 변경되었습니다.

select *
from tbl_product;

insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title, qna_contents, qna_passwd ,isdelete)
values(SEQ_QNA_BOARD.nextval, '9791197381010', 'admin', '책 재입고문의','나의 식사에는 감정이 있습니다 책 재입고 문의드립니다','qwer1234$', 0);

commit;


DELETE FROM tbl_qna_board
WHERE fk_userid = 'admin';


select * 
from ALL_TAB_COLUMNS
where TABLE_NAME = 'tbl_product' ;


SELECT *
FROM all_tab_columns 
where table_name = 'TBL_PRODUCT';
--SEMIORAUSER3	TBL_QNA_BOARD	FK_PNUM	NUMBER	
--SEMIORAUSER3	TBL_PRODUCT	PK_PRO_NUM	VARCHAR2		
--SEMIORAUSER3	TBL_PRODUCT	PRO_IMGFILE_NAME	VARCHAR2			30


alter table TBL_QNA_BOARD modify FK_PNUM VARCHAR2(30);
--Table TBL_QNA_BOARD이(가) 변경되었습니다.
alter table TBL_REVIEW_BOARD modify FK_PNUM VARCHAR2(30);
--Table TBL_REVIEW_BOARD이(가) 변경되었습니다.


DELETE FROM tbl_faq_board
WHERE fk_userid = 'admin';

commit;

select *
from tbl_product;

desc TBL_MEMBER;

desc TBL_QNA_BOARD


select *
from TBL_QNA_BOARD;


insert into tbl_qna_board(pk_qna_num, fk_userid, fk_pnum, qna_title,  qna_contents , qna_passwd, qna_issecret, isdelete) 
values(SEQ_QNA_BOARD.nextval , 'admin', '9791196045999' , '커피한잔 문의', '상품문의입니다', '1234', '0', '0');
