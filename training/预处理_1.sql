#training中把没有信用卡信息的用户删掉！
#5个表重新生成！bill除外！
use training;
#1:userinfo
drop table if exists userinfo_new;
create table userinfo_new
(
select * from userinfo 
where 
user_id in(select user_id from bill_detail)
);
#2:bank_detail
drop table if exists bank_detail_new;
create table bank_detail_new
(
select * from bank_detail
where 
user_id in(select user_id from bill_detail)
);
#3:browse_history
drop table if exists browse_history_new;
create table browse_history_new
(
select * from browse_history
where 
user_id in(select user_id from bill_detail)
);
#4:loan_time
drop table if exists loan_time_new;
create table loan_time_new
(
select * from loan_time
where 
user_id in(select user_id from bill_detail)
);
#5:overdue
drop table if exists overdue_new;
create table overdue_new
(
select * from overdue
where 
user_id in(select user_id from bill_detail)
);
