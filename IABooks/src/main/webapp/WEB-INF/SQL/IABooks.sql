<<<<<<< HEAD
--
show user;
-- USER이(가) "SEMIORAUSER3"입니다.

create user semiorauser3 identified by cclass default tablespace users;
-- User MYMVC_USER이(가) 생성되었습니다.

grant connect, resource, create view, unlimited tablespace to semiorauser3;
-- Grant을(를) 성공했습니다. 권한 부여
--
=======
show user;
-- USER이(가) "SEMIORAUSER3"입니다.


SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;


