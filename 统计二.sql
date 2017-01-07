use training;
select max(loan_time),min(loan_time),(max(loan_time)-min(loan_time))/(3600*24)from loan_time;
select user_id,loan_time from loan_time where user_id=10000;
select * from bill_detail where user_id=10000;
select * from bill_detail where user_id=10023;
select * from loan_time as t2,browse_history as t3,bill_detail as t1 
where 
(t1.user_id=t3.user_id)and
(t1.user_id=t2.user_id)and
(t1.user_id=10000);
select distinct(Moneyback_status) from bill_detail;
select * from loan_time where user_id=1000;
select distinct(Time_stamp) from browse_history where user_id=1000;
select count(sex_type) from userinfo group by sex_type;
#
select count(distinct(t1.user_id)) as bank,
count(distinct(t2.user_id)) as bill,
count(distinct(t3.user_id)) as userall 
from bank_detail as t1,
bill_detail as t2,
userinfo as t3;
#
select count(distinct(user_id)) as bank from bank_detail;
select count(distinct(user_id)) as brower from browse_history;
select count(distinct(user_id)) as bill from bill_detail;
select count(distinct(user_id)) as allusers from userinfo;
select count(distinct(user_id)) as loan_users from loan_time;
#行用卡张数统计：
select user_id,count(distinct(Bank_id)) from bill_detail group by user_id;
