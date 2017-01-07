use training;
select count(user_id) from overdue_new_final;
select count(user_id) from overdue_new_final where lable=1;
select distinct(user_id) from bill_detail_new_final;
#
select distinct(user_id),count(Bank_id) from bill_detail_new_final group by user_id;
#
select t1.user_id,count(distinct(Bank_id)) from bill_detail_new_final as t1,loan_time_new_final as t2
where
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp<=t2.loan_time)
group by user_id
;
#
select user_id,avg(Credit_limit)from bill_detail_new_final group by user_id;
#去掉额度为0的卡？？看看少人没？少了20000啊！算了吧！因为信用卡额度为0还消费的大有人在！
select count(distinct(t1.user_id)) 
from 
(select * from bill_detail_new_final where Credit_limit=0) as t1;
#最值！
select user_id,min(Credit_limit)from bill_detail_new_final group by user_id;
select user_id,max(Credit_limit)from bill_detail_new_final group by user_id;
#
select user_id,sum(Moneyback_status)/count(Moneyback_status) as 1_times,(count(Moneyback_status)-sum(Moneyback_status))/count(Moneyback_status) as 0_times
from bill_detail_new_final group by user_id;
select user_id,count(user_id) from bill_detail_new_final group by user_id;
#
select * from bill_detail_new_final where Moneyback_status=1;
#
select t1.user_id,sum(t1.lastTime_moneyReturn)/sum(t1.lastTime_moneyUsing) from bill_detail_new_final as t1 group by t1.user_id;
#
select sum(t1.lastTime_moneyReturn)/sum(t1.lastTime_moneyUsing) from bill_detail_new_final as t1,loan_time_new_final as t2 where
(t1.user_id=t2.user_id)
and(t1.bill_time_stamp<=t2.loan_time)
group by t1.user_id
;
#0检查！
select * from
(select user_id as a,count(Moneyback_status) as b from bill_detail_new_final group by user_id)as t1
;
#贷前人数统计！
select count(distinct(t1.user_id)) from bill_detail_new_final as t1 inner join loan_time_new_final as t2
on
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp<=t2.loan_time)
;
#贷后人数统计！
select count(distinct(t1.user_id)) from bill_detail_new_final as t1 inner join loan_time_new_final as t2
on
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp>t2.loan_time)
;
#
select count(distinct(t1.user_id)) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_1));
#
select count(distinct(user_id)) from features_1;
#testing
use testing;
select count(distinct(user_id)) from userid_predict_final;
select count(distinct(user_id)) from loan_time_new_final;
select count(distinct(user_id)) from bill_detail;
#training
select user_id,Bank_id,Credit_limit from bill_detail_new_final;
select t1.user_id,t1.Bank_id,t1.benqizhangdanjine,t1.benqizhangdanyue,t1.adjust_money from bill_detail_new_final as t1;
#
select t1.user_id,avg(t1.benqizhangdanyue),max(t1.benqizhangdanyue),min(t1.benqizhangdanyue) from bill_detail_new_final as t1 group by t1.user_id;








