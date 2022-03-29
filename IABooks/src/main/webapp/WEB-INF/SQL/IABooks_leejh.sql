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
		REFERENCES tbl_member ( -- 회원
			pk_userid -- 회원아이디
		);
--Table TBL_FAQ_BOARD이(가) 변경되었습니다.

------------------------------------------------------//
select *
from tabs;

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

