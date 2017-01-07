use training;
select count(distinct(user_id)) from userinfo;
select count(distinct(user_id)) from bank_detail;
select count(distinct(user_id)) from bill_detail;
select count(distinct(user_id)) from browse_history;
select count(distinct(user_id)) from loan_time;
select count(distinct(user_id)) from userid_predict;
select count(user_id) from overdue where lable=1;
#时间统计咯！
select max(Time_stamp) from bank_detail;
select distinct(Time_stamp) from bank_detail where user_id=1000 order by Time_stamp;
select distinct * from loan_time where user_id=1000;
select user_id, loan_time from loan_time order by user_id;