#feature_1 id补齐！
insert into features_1 (features_1.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from userid_predict_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_1))
);
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
#lable
#lable int(10) not null
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
t2.max_lastmoneyuse
#lable
#t3.lable  
from
userinfo_new_final as t1,
features_1 as t2,
userid_predict_final as t3
#go on...
where
(t3.user_id=t1.user_id)and
(t3.user_id=t2.user_id)
)
;