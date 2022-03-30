select * from tbl_member
--
show user;
-- USER이(가) "SEMIORAUSER3"입니다.

create user semiorauser3 identified by cclass default tablespace users;
-- User MYMVC_USER이(가) 생성되었습니다.

grant connect, resource, create view, unlimited tablespace to semiorauser3;
-- Grant을(를) 성공했습니다. 권한 부여
--

show user;
-- USER이(가) "SEMIORAUSER3"입니다.


SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;


<<<<<<< HEAD
SELECT * FROM tabs;

SELECT * FROM dba_tables;
=======
drop table tbl_main_image purge; 
-- Table TBL_MAIN_IMAGE이(가) 삭제되었습니다.

commit;
-- 커밋 완료.
>>>>>>> branch 'jodn' of https://github.com/yullim07/IABooks.git


ALTER TABLE SEMIORAUSER3.TBL_PRODUCT MODIFY PRO_PAGES NUMBER(5);
ALTER TABLE SEMIORAUSER3.TBL_PRODUCT MODIFY PK_PRO_NUM NUMBER(20);
ALTER TABLE SEMIORAUSER3.TBL_WRITER MODIFY PK_WR_CODE NUMBER(5);
ALTER TABLE SEMIORAUSER3.TBL_PRODUCT MODIFY FK_WR_CODE NUMBER(10);
ALTER TABLE SEMIORAUSER3.TBL_PRODUCT_IMAGEFILE MODIFY FK_PRO_NUM NUMBER(20)
ALTER TABLE SEMIORAUSER3.TBL_CATEGORY MODIFY PK_CATE_NUM NUMBER(5);
ALTER TABLE SEMIORAUSER3.TBL_WRITER MODIFY PK_WR_CODE NUMBER(10);

ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_writer_TO_tbl_product
		FOREIGN KEY (
			fk_wr_code
		)
		REFERENCES tbl_writer (
			pk_wr_code
		);
commit
------------------------------------------------------------------------------------------------


select pro_name, pro_saleprice, pro_imgfile_name 
from 
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name 
from tbl_product
order by pro_name desc
)V
)T
where rno between 10 and 20;



-- 새 컬럼을 생성 (기존 데이터를 옮겨담을 컬럼)
ALTER TABLE TBL_PRODUCT ADD PK_PRO_NUM_COPY VARCHAR2(20);

UPDATE TBL_PRODUCT SET PK_PRO_NUM_COPY = PK_PRO_NUM;
commit;