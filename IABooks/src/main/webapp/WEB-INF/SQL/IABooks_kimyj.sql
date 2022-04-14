show user;
-- USER이(가) "SEMIORAUSER3"입니다.
    
   
-- TBL_CATEGORY insert start --        
insert into TBL_CATEGORY(PK_CATE_NUM, CATE_NAME)
values(101,'인문');
insert into TBL_CATEGORY(PK_CATE_NUM, CATE_NAME)
values(102,'사회');
insert into TBL_CATEGORY(PK_CATE_NUM, CATE_NAME)
values(103,'과학');
insert into TBL_CATEGORY(PK_CATE_NUM, CATE_NAME)
values(104,'기타');
commit;
SELECT * FROM TBL_CATEGORY;
-- TBL_CATEGORY insert end --   

-- TBL_WRITER insert start --
--엑셀로 작업--

-- TBL_WRITER insert end --    


--인덱스 띄위기--
select pro_name, pro_imgfile_name, cate_name, pk_pro_num, PRO_SALES, PRO_VIEWCNT
 from
( 
select rownum as rno, A.* 
from 
( 
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, PRO_SALES, pk_pro_num, cate_name, PRO_VIEWCNT 
from tbl_product
join
tbl_category 
on fk_cate_num = pk_cate_num
order by DBMS_RANDOM.RANDOM
)A
)B
where rno between 1 and  8;




select pro_name, pro_imgfile_name, cate_name, pk_pro_num "
    + " from "
    + " ( "
        + " select rownum as rno, A.* "
        + " from "
        + " ( "
            + " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, TBL_PRODUCT, pk_pro_num, cate_name "
            + " from tbl_product "
            + " join "
            + " tbl_category V "
            + " on fk_cate_num = pk_cate_num "
            + " order by TBL_PRODUCT desc "
        + " )A "
    + " )B "
    + " where rno between 1 and  20 ";





---

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
where rno between 1 and 10;
			
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, 
from tbl_product
group by fk_cate_num
)V1

join
(
select pk_cate_num, cate_name
from TBL_CATEGORY;
)V2
on fk_cate_num = pk_cate_num;

select A.pro_name, A.pro_saleprice, A.pro_imgfile_name, A.fk_cate_num, B.cate_name
from tbl_product A, TBL_CATEGORY B
where A.fk_cate_num = B.pk_cate_num;


--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rno, pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
order by pro_name
)V
 )A
JOIN 
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
where cate_name = 'humanities'
}
rno between 1 and 10
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
order by pro_name
)A
JOIN 
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
--where cate_name = 'humanities'
where cate_name = *
)V
where rno between 3 and  10;

select *
from tbl_product


order by  pro_name


select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product

) A
JOIN 
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
where rno between ? and ? ";
order by  pro_name




select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales 
from tbl_product
order by pro_inputdate desc

select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales 
from tbl_product
order by pro_name asc

select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales 
from tbl_product
order by pro_sales desc

--
select rno pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
order by pro_inputdate desc
)A
JOIN
TBL_CATEGORY B
on fk_cate_num = pk_cate_num

)V
where rno between 1 and  100

--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
)A
JOIN
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
order by pro_name
)V
where rno between 1 and  100 



--


select rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
)A
JOIN
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
order by pro_sales desc
)V
where rno between 1 and  5
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, A.*
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, cate_name 
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
order by pro_sales desc, pro_name
)A
)B
where rno between 1 and  20
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, A.*
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, cate_name 
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where pro_inputdate > add_months(sysdate, -12)
order by pro_inputdate desc, pro_name
)A
)B
where rno between 1 and  20
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, A.*
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales,PRO_RESTOCK, cate_name 
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where PRO_RESTOCK = 1
order by pro_inputdate desc, pro_name
)A
)B
where rno between 1 and  20
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pro_inputdate, pk_pro_num
from
(
select rownum as rno, A.*
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, PRO_SOLDOUT, pk_pro_num, cate_name 
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where PRO_SOLDOUT = 0 and pro_inputdate < add_months(sysdate, -36)
order by DBMS_RANDOM.RANDOM
)A
)B
where rno between 1 and  20
--
select rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name, pro_inputdate, pk_pro_num
from
(
select rownum as rno, A.*
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, PRO_SOLDOUT, pk_pro_num, cate_name 
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where cate_name = 'humanities'
order by pro_inputdate desc
)A
)B
where rno between 1 and  20

---
select pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name
from
(
select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales
from tbl_product
)A
JOIN
TBL_CATEGORY B
on fk_cate_num = pk_cate_num
order by pro_name
)V
where rno between 1 and  100 



select ceil(count(*)/12) 
from tbl_product 
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where cate_name = 'humanities'

select ceil(count(*)/12), count(*) 
from tbl_product 
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
where cate_name = 'other'

select ceil(count(*)/12)
from tbl_product
where cate_name='humanities'
--
select *
from
(
select *
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
)
JOIN
TBL_WRITER V2
on FK_WR_CODE = PK_WR_CODE
where PRO_NAME like '%'||'새벽'||'%' or PUBLISHER like '%'||'새벽'||'%' or PK_PRO_NUM like '%'||'88'||'%' or WR_NAME like '%'||'김필통'||'%'
order by pro_inputdate desc
--
select ceil(count(*)/12), count(*)
from
(
select *
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
)
JOIN
TBL_WRITER V2
on FK_WR_CODE = PK_WR_CODE
where PRO_NAME like '%'||'새벽'||'%' or PUBLISHER like '%'||'새벽'||'%' or PK_PRO_NUM like '%'||'88'||'%' or WR_NAME like '%'||'김필통'||'%'
--
select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num
from
(
select rownum as rno, A.*
from
(
select *
from
(
select *
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
)
JOIN
TBL_WRITER V2
on FK_WR_CODE = PK_WR_CODE
where PRO_NAME like '%'||'새벽'||'%' or PUBLISHER like '%'||'새벽'||'%' or PK_PRO_NUM like '%'||'새벽'||'%' or WR_NAME like '%'||'새벽'||'%'
order by pro_inputdate desc
)A
)B
where rno between 1 and  20
--
select ceil(count(*)/12), count(*) 
from 
( 
select *
from tbl_product 
 join V 
tbl_category V 
on fk_cate_num = pk_cate_num 
) 
join 
tbl_writer V2
on fk_wr_code = pk_wr_code 
where pro_name like '%'|| '커피' ||'%' or publisher like '%'|| '커피' ||'%' or pk_pro_num like '%'|| '커피' ||'%' or wr_name like '%'|| '커피' ||'%'
--
select ceil(count(*)/12), count(*)
from
(
select *
from tbl_product
JOIN
TBL_CATEGORY V
on fk_cate_num = pk_cate_num
)
JOIN
TBL_WRITER V2
on FK_WR_CODE = PK_WR_CODE
where PRO_NAME like '%'||'커피'||'%' or PUBLISHER like '%'||'커피'||'%' or PK_PRO_NUM like '%'||'98'||'%' or WR_NAME like '%'||'커피'||'%'
--

SELECT PRO_NAME, PUBLISHER, PRO_PUBLISH_DATE, PRO_SALEPRICE, PRO_VIEWCNT, PRO_SIZE, nvl(PRO_BINDTYPE, '-')
FROM
tbl_product 

SELECT PRO_NAME, PUBLISHER, PRO_PUBLISH_DATE, PRO_SALEPRICE, PRO_VIEWCNT, PRO_SIZE, nvl(PRO_BINDTYPE, ' '), PRO_PAGES, PRO_IMGFILE_NAME,
PK_PRO_NUM, PRO_SOLDOUT, PRO_RESTOCK,
WR_NAME, nvl(WR_INFO, ' '), CATE_NAME
--, nvl(PRO_INDEX, ' '), nvl(PRO_CONTENT, ' ')
FROM
tbl_product 
JOIN 
tbl_writer
ON fk_wr_code = pk_wr_code
JOIN 
tbl_category
ON fk_cate_num = pk_cate_num
WHERE pk_pro_num = '9791190362078'

--WR_INFO  PRO_INDEX PRO_CONTENT PRO_BINDTYPE
nvl(PRO_BINDTYPE, '')

LEFT OUTER JOIN 
tbl_writer B 
ON A.fk_wr_code = B.pk_wr_code
LEFT OUTER JOIN 
tbl_category C 
ON A.fk_cate_num = C.pk_cate_num
WHERE pk_pro_num = ?




update tbl_product set pro_viewcnt = pro_viewcnt+1 where pk_pro_num = '9791190362078';

select cname, cprice, cminprice
from
TBL_USER_COUPON_STATUS
join TBL_coupon
on COUPON_ID = PK_COUPON_ID
where fk_userid = 'admin' and USER_CP_STATUS = 1 and cenddate >= sysdate;

select pk_cartno
from tbl_cart
join tbl_product
on fk_pro_num = pk_pro_num
where fk_pro_num = '9791167470317' and fk_userid = 'admin';

select cprice
from
tbl_user_coupon_status
join tbl_coupon
on coupon_id = pk_coupon_id
where pk_coupon_id = '016895314611809' ;



create sequence seq_order_ordercode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


seq_tbl_order


create sequence seq_tbl_order
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select a.sid, a.serial# from v$session a, v$lock b, dba_objects c 
where a.sid = b.sid and b.id1=c.object_id and b.type='TM' and c.object_name='TBL_ORDERDETAIL';

select a.sid, a.serial# 
from v$session a, v$lock b, dba_objects c 
where a.sid = b.sid and b.id1=c.object_id and b.type='TM' and c.object_name='tbl_ptoduct';

SELECT A.SID, A.SERIAL#
FROM V$SESSION A, V$LOCK B, DBA_OBJECTS C
WHERE A.SID=B.SID AND B.ID1=C.OBJECT_ID AND B.TYPE='TM' AND C.OBJECT_NAME='tbl_ptoduct';



 select O.fk_userid , to_char(O.odr_date , 'yyyy-MM-dd') , C.cate_name, P.pro_imgfile_name , P.pro_name , G.ck_odr_totalqty, O.odr_totalprice , D.delivername 
from tbl_order O 
join tbl_orderdetail G 
on o.pk_odrcode = g.fk_odrcode 
join tbl_product P 
on G.fk_pro_num = P.pk_pro_num 
join tbl_category C 
on C.pk_cate_num = P.fk_cate_num 
join tbl_deliverstatus D 
on G.ck_deliverstatus = D.deliverstatus 
where O.fk_userid = 'qwer8218'
and O.odr_date  between '2022-01-14' and '2022-04-14'
                  
and d.deliverstatus between '0' and '6'
order by odr_date DESC 
