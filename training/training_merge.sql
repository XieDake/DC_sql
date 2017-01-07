#feature_1 id补齐！
insert into features_1 (features_1.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_1))
);
#merge: features_1,user_info,overdue
#create table!
drop table if exists training_merge;
create table training_merge
(
user_id int(20) not null,
#用户基本属性！这个表是全的！非空即可！
sex_type int(10) not null default 0,
occupation int(10)not null,
education int(10) not null,
marriage int(10) not null,
person_typpe int(10) not null, 
#用户贷前行用卡特征！
credit_card_numbers int(10) not null default 0,#0.018
mean_credit_limit float not null default 0,#0.057
max_credit_limit float not null default 0,#0.038
min_credit_limit float not null default 0,#0.020
s_1_times int(10) not null default 0,#0.00014
s_1_times_prob float not null default 0,#0.00035
s_0_times int(10) not null default 0,#0.072
s_0_times_prob float not null default 0,#0.0125
mean_cycle_interest float not null default 0,#0.027
max_cycle_interest float not null default 0,#0.027
min_cycle_interest float not null default 0,#0.0018
mean_zuidihuankuan float not null default 0,#0.085
min_zuidihuankuan float not null default 0,#0.063
max_zuidihuankuan float not null default 0,#0.09
mean_moneyreturn_rate float not null default 0,#0.081
mean_lastmoneyreturn float not null default 0,#0.060
min_lastmoneyreturn float not null default 0,#0.017
max_lastmoneyreturn float not null default 0,#0.066
mean_lastmoneyuse float not null default 0,#0.051
min_lastmoneyuse float not null default 0,#0.034
max_lastmoneyuse float not null default 0,#0.061
#lable
lable int(10) not null
);
#insert:注意user全的在overdue:53174！
insert into training_merge
(
select 
t3.user_id,
#用户基本属性！:5
t1.sex_type,
t1.occupation,
t1.education,
t1.marriage,
t1.person_type,
#features_1:21
t2.credit_card_numbers,
t2.mean_credit_limit,
t2.max_credit_limit,
t2.min_credit_limit,
t2.s_1_times,
t2.s_1_times_prob,
t2.s_0_times,
t2.s_0_times_prob,
t2.mean_cycle_interest,
t2.max_cycle_interest,
t2.min_cycle_interest,
t2.mean_zuidihuankuan,
t2.min_zuidihuankuan,
t2.max_zuidihuankuan,
t2.mean_moneyreturn_rate,
t2.mean_lastmoneyreturn,
t2.min_lastmoneyreturn,
t2.max_lastmoneyreturn,
t2.mean_lastmoneyuse,
t2.min_lastmoneyuse,
t2.max_lastmoneyuse,
#lable
t3.lable  
from
userinfo_new_final as t1,
features_1 as t2,
overdue_new_final as t3
#go on...
where
(t3.user_id=t1.user_id)and
(t3.user_id=t2.user_id)
)
;
#划分正负样本集！
drop table if exists training_positive_1;
#0
create table training_positive_1
(
select * from training_merge
where lable=0
);
#1
drop table if exists training_negtive_1;
create table training_negtive_1
(
select * from training_merge
where lable=1
);






