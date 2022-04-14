show user;
-- USER이(가) "SEMIORAUSER3"입니다.

select *
from tabs;

select *
from tbl_member;



select fk_userid, odr_date, cate_name, pro_imgfile_name, pro_name, ck_odr_totalqty, odr_price, delivername
from
(
select row_number() over(order by ODR_DATE  desc) as rno, O.fk_userid , to_char(O.odr_date , 'yyyy-MM-dd')as odr_date  , C.cate_name, 
P.pro_imgfile_name , P.pro_name , G.ck_odr_totalqty, G.odr_price , D.delivername 
 from tbl_order O 
 join tbl_orderdetail G 
 on o.pk_odrcode = g.fk_odrcode 
 join tbl_product P 
 on G.fk_pro_num = P.pk_pro_num 
 join tbl_category C 
 on C.pk_cate_num = P.fk_cate_num 
 join tbl_deliverstatus D 
 on G.ck_deliverstatus = D.deliverstatus 
 where O.fk_userid = 'moonby' and D.deliverstatus between 0 and 6
 and O.odr_date   between '2021-12-25'  and '2022-04-15'
)V
where V.rno between 0 and 10;
