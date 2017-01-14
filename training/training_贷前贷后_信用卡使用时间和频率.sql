use training;
#试一下这个特征：
#(用时间来反映，因为时间是唯一标识的！正常来说每一个月都应该是有记录的，这里是应该有什么解释的！为什么有的人！
#1：贷前信用卡使用次数统计，贷前信用卡使用时间统计(min,max,bias)，贷前信用卡使用张数的统计！
#2：贷后信用卡使用次数统计，贷后信用卡使用时间统计(min,max,bias)，贷后信用卡使用张数统计！
##############################################################################################
##############################################################################################
#前
drop table if exists features_credit_1_before;
create table features_credit_1_before
(
user_id int(10) not null,
#1:贷前信用卡使用次数统计！用时间来统计！
credit_use_times int(10) not null default 0,
#2:贷前信用卡使用时间统计(min,max,mean)
min_credit_time_use bigint not null default 0,
max_credit_time_use bigint not null default 0,
bias_credit_time_use bigint not null default 0,
#3:贷前信用卡活跃张数的统计！
creditCard_active int(10) not null default 0
);
#insert
insert into features_credit_1_before
(
select
t1.user_id,
#1:贷前信用卡使用次数统计！用时间来统计！
count(distinct(t1.bill_time_stamp)),
#2:贷前信用卡使用时间统计(min,max,mean)
min(t2.loan_time-t1.bill_time_stamp),
max(t2.loan_time-t1.bill_time_stamp),
max(t2.loan_time-t1.bill_time_stamp)-min(t2.loan_time-t1.bill_time_stamp),
#3:贷前信用卡活跃张数的统计！
count(distinct(t1.Bank_id))
from
bill_detail_new_final as t1,
loan_time_new_final as t2 
where
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp<=t2.loan_time)
group by
t1.user_id
);
#user_id 补齐！
insert into features_credit_1_before (features_credit_1_before.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_credit_1_before))
);
##############################################################################################
##############################################################################################
#后
drop table if exists features_credit_1_after;
create table features_credit_1_after
(
user_id int(10) not null,
#1:贷前信用卡使用次数统计！用时间来统计！
credit_use_times int(10) not null default 0,
#2:贷前信用卡使用时间统计(min,max,mean)
min_credit_time_use bigint not null default 0,
max_credit_time_use bigint not null default 0,
bias_credit_time_use bigint not null default 0,
#3:贷前信用卡活跃张数的统计！
creditCard_active int(10) not null default 0
);
#insert
insert into features_credit_1_after
(
select
t1.user_id,
#1:贷前信用卡使用次数统计！用时间来统计！
count(distinct(t1.bill_time_stamp)),
#2:贷前信用卡使用时间统计(min,max,mean)
min(t1.bill_time_stamp-t2.loan_time),
max(t1.bill_time_stamp-t2.loan_time),
max(t1.bill_time_stamp-t2.loan_time)-min(t1.bill_time_stamp-t2.loan_time),
#3:贷前信用卡活跃张数的统计！
count(distinct(t1.Bank_id))
from
bill_detail_new_final as t1,
loan_time_new_final as t2 
where
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp>t2.loan_time)
group by
t1.user_id
);
#user_id 补齐！
insert into features_credit_1_after (features_credit_1_after.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_credit_1_after))
);
###################################################################################
#####################################################################################
###################################################################################
#features_credit_1_later和features_credit_1_before合并！
#12维！
drop table if exists features_credit_1;
create table features_credit_1
(
select
t3.user_id,
#贷前:5;
t1.credit_use_times as credit_use_times_before,
t1.min_credit_time_use as min_credit_time_use_before,
t1.max_credit_time_use as max_credit_time_use_before,
t1.bias_credit_time_use as bias_credit_time_use_before,
t1.creditCard_active as creditCard_active_before,
#贷后:5;
t2.credit_use_times as credit_use_times_after,
t2.min_credit_time_use as min_credit_time_use_after,
t2.max_credit_time_use as max_credit_time_use_after,
t2.bias_credit_time_use as bias_credit_time_use_after,
t2.creditCard_active as creditCard_active_after,
#交叉：2
abs(t1.min_credit_time_use-t2.min_credit_time_use) as bias_1,
abs(t1.credit_use_times-t2.credit_use_times) as bias_2
from 
features_credit_1_before as t1,
features_credit_1_after as t2,
overdue_new_final as t3
where
(t3.user_id=t1.user_id)
and
(t3.user_id=t2.user_id)
);
