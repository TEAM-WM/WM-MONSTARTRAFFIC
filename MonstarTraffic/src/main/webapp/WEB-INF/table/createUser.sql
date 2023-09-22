show user;
-- 시스템 계정으로 해주셔야합니다. system/oracle ||||| system/123456
--사용자 만들기
create user monstar IDENTIFIED by 123456;

--권한설정
grant connect,resource,dba to monstar;
show user;

--사용자 삭제
-- drop user monstar cascade;