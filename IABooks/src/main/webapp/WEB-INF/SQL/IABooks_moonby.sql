show user;
-- USER이(가) "SEMIORAUSER3"입니다.

select *
from tabs;

select *
from tbl_member;

select * 
from tbl_deliverstatus



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
where O.fk_userid = 'admin' 
and O.odr_date  between '2022-01-12' and '2022-04-14'
and d.deliverstatus  between '0' and '6'
order by odr_date DESC ;

