use training;
#1提取贷后用户信用卡数目特征
#2提取贷后用户信用特征（银行反应之！）
#3用户行用卡的还款能力！
#话说有些人没有贷前信息，只有贷后信息！
drop table if exists features_1_later;
create table features_1_later
(
user_id int(20) not null,
credit_card_numbers int(10) not null default 0,
mean_credit_limit float not null default 0,
max_credit_limit float not null default 0,
min_credit_limit float not null default 0,
s_1_times int(10) not null default 0,
s_1_times_prob float not null default 0,
s_0_times int(10) not null default 0,
s_0_times_prob float not null default 0,
mean_cycle_interest float not null default 0,
max_cycle_interest float not null default 0,
min_cycle_interest float not null default 0,
mean_zuidihuankuan float not null default 0,
min_zuidihuankuan float not null default 0,
max_zuidihuankuan float not null default 0,
mean_moneyreturn_rate float not null default 0,
mean_lastmoneyreturn float not null default 0,
min_lastmoneyreturn float not null default 0,
max_lastmoneyreturn float not null default 0,
mean_lastmoneyuse float not null default 0,
min_lastmoneyuse float not null default 0,
max_lastmoneyuse float not null default 0
);
#insert
insert into features_1_later
(select 
t1.user_id,
#信用卡数目
count(distinct(t1.Bank_id)),
#信用信息！
avg(t1.Credit_limit),
max(t1.Credit_limit),
min(t1.Credit_limit),
#还款能力！
sum(t1.Moneyback_status),
sum(t1.Moneyback_status)/(count(t1.Moneyback_status)+0.00000000001),#100亿大数，除以0处理！
count(t1.Moneyback_status)-sum(t1.Moneyback_status),
(count(t1.Moneyback_status)-sum(t1.Moneyback_status))/(count(t1.Moneyback_status)+0.00000000001),
avg(t1.cycle_interist),
max(t1.cycle_interist),
min(t1.cycle_interist),
avg(t1.benqizuidihuankuanjine),
min(t1.benqizuidihuankuanjine),
max(t1.benqizuidihuankuanjine),
sum(t1.lastTime_moneyReturn)/(sum(t1.lastTime_moneyUsing)+0.00000000001),
avg(t1.lastTime_moneyReturn),
min(t1.lastTime_moneyReturn),
max(t1.lastTime_moneyReturn),
avg(t1.lastTime_moneyUsing),
min(t1.lastTime_moneyUsing),
max(t1.lastTime_moneyUsing)
from
bill_detail_new_final as t1,
loan_time_new_final as t2
where 
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp>t2.loan_time)
#group by是对where筛选的结果进行group！所以人数肯定没有补齐咯！
group by t1.user_id
);
#防止除0，处理！update!
#3个率！
#1
update features_1_later
set s_1_times_prob=0
where 
(s_1_times_prob>100000000);
#2
update features_1_later
set s_0_times_prob=0
where 
(s_0_times_prob>100000000)
;
#3
update features_1_later
set mean_moneyreturn_rate=0
where 
(mean_moneyreturn_rate>100000000);
#feature_1 id补齐！
insert into features_1_later (features_1_later.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_1_later))
);
