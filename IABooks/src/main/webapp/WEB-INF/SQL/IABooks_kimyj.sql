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






----------------------------------------------------------------------------------------------------------------       
insert into tbl_product(PK_PRO_NUM, FK_CATE_NUM, PRO_NAME, PUBLISHER, PRO_PUBLISH_DATE, PRO_PRICE,PRO_SALEPRICE,
PRO_INPUTDATE, PRO_SIZE, PRO_BINDTYPE, PRO_PAGES, PRO_IMGFILE_NAME, FK_WR_CODE, PRO_INDEX, PRO_CONTENT)   
values(9791189249052, 103, '뇌를 읽다│원제 Leading Brain', '빈티지하우스', '2018-09-10', 18000, 18000,
'2018-09-17', '국판 변형', '', 380,'9791189249052.jpg', 1001,
'"여는 말_(어쩌면 당신의 리더는 한 번도 제대로 써보지 못한) 뇌의 비밀

1부 당신의 최적점에 도달하는 법

1장 나만의 스윗스팟을 찾아라_최고의 성과를 만들어주는 레시피

최고의 성과를 찾아서 / 자극의 해부학 / 단 하나의 법칙은 존재하지 않는다 / 당신의 위치를 찾아서 / 상승과 하락



2장 감정을 조절하라_당신의 감정 온도를 효과적으로 조절하는 방법을 터득하라

우리의 원시적인 네트워크 / 전쟁 중인 두뇌



3장 집중력을 가다듬어라_중요한 사안에 집중하고 방해물에 대한 통제력을 얻어라집중력 이해하기 / 주의분산 물리치기 / 방황하는 마음을 진정시키기 / 몰입의 달성





2부 당신의 두뇌를 변화시키는 법



4장 습관을 관리하라_자동운전 모드로 작동할 수 있는 두뇌의 능력을 활용하라



5장 무의식을 해방하라_가장 빠르고 가장 좋은 결정은 종종 무의식 속에서 이루어진다



6장 학습능력을 길러라_‘늙은 개에게 새로운 재주를 가르칠 수 없다’라는 말은 사실일지도 모른다. 그러나 우리는 개가 아니다

배움에서 가르침까지





3부 드림팀을 결성하는 법



7장 다양성을 바탕으로 성공하라_성격과 역량의 균형을 통해 비즈니스에서 변화를 만들어낸다



8장 신뢰를 구축하라_신뢰는 금전보다 팀을 더 효과적으로 팀을 묶어준다



9장 미래의 팀으로 성장하라_팀원을 행복하게 만들고 최고의 성과를 내는 두뇌친화적 시스템



강점을 바탕으로 팀 구성하기 / 최고의 팀 유지하기 / 집단 최고의 성과 달성



맺는 말_당신의 사무실로 뇌과학자를 초대하라"
',
'"내 거친 생각과 // 불안한 눈빛과 // 그걸 조종하는 뇌의 비밀!

“이 책은 뇌과학이 전하는 삶의 지침서가 될 것이다!”_정재승(뇌과학자) 추천사 중 “뇌과학 책을 한 권만 읽을 수 있다면 이 책을 읽어야 한다.”_아마존 독자서평 중



※ 최근 주목받고 있는 ‘뉴로리더십’에 대한 뇌과학의 탁월한 조언!

뉴로리더십 전문가로 세계적으로 인정받고 있는 두 저자는 명쾌하고 실용적인 뇌과학 이야기로 당신이 일할 때(혹은 일하기 싫어하는 대부분의 순간에도!) 우리 두뇌에서 벌어지는 일들을 다양한 사례와 연구를 통해 분석한다.



※ 뇌 이야기라고 겁먹지 말 것!

수많은 기업의 임원과 직원들이 페이지를 아껴가며 읽은 이 책은 시종일관 경쾌하고 심지어 웃기기까지 하다. 일과 삶에서 당신이 원하는 모든 순간에 최고로 효율적이고 효과적으로 작동하는 뇌를 만들기 위한 설득력 있는 조언은 덤처럼 느껴질 것이다.



★★★★★<Strategy+Business> 선정 베스트 비즈니스북(2017)

★★★★★<Success> 선정 베스트북(2017)"
'
);   
--국제표준도서번호, 카테고리번호, 도서명, 출판사명, 출간일, 도서정가, 도서판매가, 
--도서입고일, 크기, 제본타입, 페이지, 이미지이름, 저자코드, 목차, 도서소개