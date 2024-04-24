-- will create the databases that will contain all the tables needed by wordpress
create database if not exists :DB_NAME;
-- this would be the user that wordpress will use to connect to the database
-- note that in order to connect from outside the container we will pass % wildcard
create user if not exists ':USER'@'%' identified by ':UPASS';
-- The user will not have access to do CRUD operations on the database thus we need  to give privileges to that user.
grant all privileges on :DB_NAME.* to ':USER'@'%' identified by ':UPASS';
flush privileges;
create user if not exists ':ADMIN'@'%' identified by ':APASS';
grant all privileges on *.* to ':ADMIN'@'%';
flush privileges;
