------- ***** IABooks 에서 작업한 것 ***** -------

show user;
-- USER이(가) "SEMIORAUSER3"입니다.

create table tbl_main_image
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_image primary key(imgno)
);

SELECT
    *
FROM
    tbl_main_image;