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
	cmt_date     DATE default sysdate -- 작성일자
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
	qna_issecret  VARCHAR2(5)    NULL      -- 비밀유무
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
	re_writer    VARCHAR2(10)   NOT NULL  -- 작성자
);


