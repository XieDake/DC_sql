use training;
#提取用户贷前交叉特征！综合！
#暂时13维！
drop table if exists features_3;
create table features_3
(
user_id int(10) not null,
time_creditUsing bigint not null default 0,
mean_last_using_back float not null default 0,
rate_consume_lastback float not null default 0,
rate_consume_back float not null default 0,
limit_lastusing float not null default 0,
limit_thisusing float not null default 0,
mean_thisneedback_thisusing float not null default 0,
mean_consume float not null default 0,
rate_consume_cycle float not null default 0,
rate_consumetimes_cycle float not null default 0,
rate_cycle_limit float not null default 0,
rate_consume_limit float not null default 0,
rate_lastback_limit float not null default 0
);
# insert
insert into features_3
(
select
t1.user_id,
#13维交叉特征！
(min(t2.loan_time)-min(t1.bill_time_stamp))/(3600*24),#天为单位！
avg(t1.lastTime_moneyUsing-t1.lastTime_moneyReturn),
(sum(t1.benqizhangdanjine)-sum(t1.adjust_money))/(sum(t1.lastTime_moneyReturn)+0.00000000001),
min(t4.consumed_rate)-min(t3.mean_moneyreturn_rate),#唯一，哈哈！
avg(t1.Credit_limit-t1.lastTime_moneyUsing),
avg(t1.Credit_limit-t1.benqizhangdanjine),
avg(t1.benqizhangdanyue-t1.benqizhangdanjine),
avg(t1.benqizhangdanjine-t1.adjust_money),
sum(t1.benqizhangdanjine-t1.adjust_money)/(sum(t1.cycle_interist)+0.00000000001),
sum(t1.consume_times)/(sum(t1.cycle_interist)+0.00000000001),
sum(t1.cycle_interist)/(sum(t1.Credit_limit)+0.00000000001),
sum(t1.benqizhangdanjine-t1.adjust_money)/(sum(t1.Credit_limit)+0.00000000001),
sum(t1.lastTime_moneyReturn)/(sum(t1.Credit_limit)+0.00000000001)
from
bill_detail_new_final as t1,
loan_time_new_final as t2,
features_1 as t3,
features_2 as t4
#
where
(t1.user_id=t2.user_id)
and
(t1.user_id=t3.user_id)
and
(t1.user_id=t4.user_id)
and
(t1.bill_time_stamp<=t2.loan_time)
#group by
group by t1.user_id
);
#防止除0，处理！update!
#6处！
#1
update features_3
set 
rate_consume_lastback=0
where
(rate_consume_lastback>100000000);
#2
update features_3
set 
rate_consume_cycle=0
where
(rate_consume_cycle>100000000);
#3
update features_3
set 
rate_consumetimes_cycle=0
where
(rate_consumetimes_cycle>100000000);
#4
update features_3
set 
rate_cycle_limit=0
where
(rate_cycle_limit>100000000);
#5
update features_3
set 
rate_consume_limit=0
where
(rate_consume_limit>100000000);
#6
update features_3
set 
rate_lastback_limit=0
where
(rate_lastback_limit>100000000);
#user_id 补齐！
#feature_1_later id补齐！
insert into features_3 (features_3.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_3))
);
