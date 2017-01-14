use training;
#merge: features_0,features_1,features_2,features_3,overdue
#create table!
drop table if exists training_merge_2017111;
create table training_merge_2017111
(
user_id int(20) not null,
#用户基本属性！和变种15：features_0
sex_type int(10) not null default 0,
occupation int(10)not null,
education int(10) not null,
marriage int(10) not null,
person_typpe int(10) not null, 
sex_occupation float not null,
sex_education float not null,
sex_marriage float not null,
sex_persontype float not null,
occupation_education float not null,
occupation_marriage float not null,
occupation_persontype float not null,
education_marriage float not null,
education_persontype float not null,
marriage_persontype float not null,
#用户贷前行用卡特征！21: features_1
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
#用户贷前消费特征！18:features_2
mean_consume_numbers int(10) not null default 0,
max_consume_numbers int(10) not null default 0,
min_consume_numbers int(10) not null default 0,
mean_yue float not null default 0,
max_yue float not null default 0,
min_yue float not null default 0,
mean_jine float not null default 0,
max_jine float not null default 0,
min_jine float not null default 0,
bias_jine_yue float not null default 0,
mean_available float not null default 0,
max_available float not null default 0,
min_available float not null default 0,
mean_adjust float not null default 0,
max_adjust float not null default 0,
min_adjust float not null default 0,
consumed_money float not null default 0,
consumed_rate float not null default 0,
#用户贷前交叉特征！13维！features_3
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
rate_lastback_limit float not null default 0,
#lable
lable int(10) not null
);
#insert:注意user全的在overdue:53174！
#共有54维特征！
insert into training_merge_2017111
(
select 
t5.user_id,
#用户基本属性和变种！:15 features_0;
t1.sex_type,
t1.occupation,
t1.education,
t1.marriage,
t1.person_type,
t1.sex_occupation,
t1.sex_education,
t1.sex_marriage,
t1.sex_persontype,
t1.occupation_education,
t1.occupation_marriage,
t1.occupation_persontype,
t1.education_marriage,
t1.education_persontype,
t1.marriage_persontype,
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
#features_2:18
t3.mean_consume_numbers,
t3.max_consume_numbers,
t3.min_consume_numbers,
t3.mean_yue,
t3.max_yue,
t3.min_yue,
t3.mean_jine,
t3.max_jine,
t3.min_jine,
t3.bias_jine_yue,
t3.mean_available,
t3.max_available,
t3.min_available,
t3.mean_adjust,
t3.max_adjust,
t3.min_adjust,
t3.consumed_money,
t3.consumed_rate,
#features_3:13
t4.time_creditUsing,
t4.mean_last_using_back,
t4.rate_consume_lastback,
t4.rate_consume_back,
t4.limit_lastusing,
t4.limit_thisusing,
t4.mean_thisneedback_thisusing,
t4.mean_consume,
t4.rate_consume_cycle,
t4.rate_consumetimes_cycle,
t4.rate_cycle_limit,
t4.rate_consume_limit,
t4.rate_lastback_limit,
#lable
t5.lable
from
features_0 as t1,
features_1 as t2,
features_2 as t3,
features_3 as t4,
overdue_new_final as t5
#go on...
where
(t5.user_id=t1.user_id)
and
(t5.user_id=t2.user_id)
and
(t5.user_id=t3.user_id)
and
(t5.user_id=t4.user_id)
)
;
#划分正负样本集！
drop table if exists training_positive_2017111;
#0
create table training_positive_2017111
(
select * from training_merge_2017111
where lable=0
);
#1
drop table if exists training_negtive_2017111;
create table training_negtive_2017111
(
select * from training_merge_2017111
where lable=1
);