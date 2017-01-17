use testing;
#这里开始提取用户的浏览行为特征！
#还是分贷前和贷后！
#共有24维!
#前：12=后：12
####################################################################################
#####################################################################################
#前！12
drop table if exists features_browse_0_before;
create table features_browse_0_before
(
user_id int(10) not null,
#12
browse_days_before int(10) not null default 0,
min_browse_time_before bigint not null default 0,
max_browse_time_before bigint not null default 0,
bias_browse_time_before bigint not null default 0,
browse_hehaviour_types_before int(10) not null default 0,
max_browse_behaviour_before int(10) not null default 0,
min_browse_behaviour_before int(10) not null default 0,
mean_browse_behaviour_before float not null default 0,
browse_hehaviour_mark_types_before int(10) not null default 0,
max_browse_behaviour_mark_before int(10) not null default 0,
min_browse_behaviour_mark_before int(10) not null default 0,
mean_browse_behaviour_mark_before float not null default 0
)
;
#insert!
insert into features_browse_0_before
(
select 
t1.user_id,
#12
count(distinct(t1.Time_stamp)),
min(t2.loan_time-t1.Time_stamp)/(3600*24),
max(t2.loan_time-t1.Time_stamp)/(3600*24),
(max(t2.loan_time-t1.Time_stamp)-min(t2.loan_time-t1.Time_stamp))/(3600*24),
count(distinct(t1.browse_behaviour)),
min(distinct(t1.browse_behaviour)),
max(distinct(t1.browse_behaviour)),
avg(t1.browse_behaviour),
count(distinct(t1.browse_behaviour_mark)),
min(distinct(t1.browse_behaviour_mark)),
max(distinct(t1.browse_behaviour_mark)),
avg(t1.browse_behaviour_mark)
from 
browse_history_new_final as t1,
loan_time_new_final as t2
where
(t1.user_id=t2.user_id)
and
(t1.Time_stamp<=t2.loan_time)
group by
t1.user_id
)
;
#user_id 补齐！
insert into features_browse_0_before (features_browse_0_before.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from userid_predict_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_browse_0_before))
);
###########################################################################################
############################################################################################
#########################################################################################
#后！12
drop table if exists features_browse_0_after;
create table features_browse_0_after
(
user_id int(10) not null,
#12
browse_days_after int(10) not null default 0,
min_browse_time_after bigint not null default 0,
max_browse_time_after bigint not null default 0,
bias_browse_time_after bigint not null default 0,
browse_hehaviour_types_after int(10) not null default 0,
max_browse_behaviour_after int(10) not null default 0,
min_browse_behaviour_after int(10) not null default 0,
mean_browse_behaviour_after float not null default 0,
browse_hehaviour_mark_types_after int(10) not null default 0,
max_browse_behaviour_mark_after int(10) not null default 0,
min_browse_behaviour_mark_after int(10) not null default 0,
mean_browse_behaviour_mark_after float not null default 0
)
;
#insert!
insert into features_browse_0_after
(
select 
t1.user_id,
#12
count(distinct(t1.Time_stamp)),
min(t1.Time_stamp-t2.loan_time)/(3600*24),
max(t1.Time_stamp-t2.loan_time)/(3600*24),
(max(t1.Time_stamp-t2.loan_time)-min(t1.Time_stamp-t2.loan_time))/(3600*24),
count(distinct(t1.browse_behaviour)),
min(distinct(t1.browse_behaviour)),
max(distinct(t1.browse_behaviour)),
avg(t1.browse_behaviour),
count(distinct(t1.browse_behaviour_mark)),
min(distinct(t1.browse_behaviour_mark)),
max(distinct(t1.browse_behaviour_mark)),
avg(t1.browse_behaviour_mark)
from 
browse_history_new_final as t1,
loan_time_new_final as t2
where
(t1.user_id=t2.user_id)
and
(t1.Time_stamp>t2.loan_time)
group by
t1.user_id
)
;
#user_id 补齐！
insert into features_browse_0_after (features_browse_0_after.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from userid_predict_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_browse_0_after))
);
######################################################################
#######################################################################
#前后merge！
#features_browse_0_before,features_browse_0_after
drop table if exists features_browse_0;
create table features_browse_0
(
select
t3.user_id,
#前12
t1.browse_days_before,
t1.min_browse_time_before,
t1.max_browse_time_before,
t1.bias_browse_time_before,
t1.browse_hehaviour_types_before,
t1.max_browse_behaviour_before,
t1.min_browse_behaviour_before,
t1.mean_browse_behaviour_before,
t1.browse_hehaviour_mark_types_before,
t1.max_browse_behaviour_mark_before,
t1.min_browse_behaviour_mark_before,
t1.mean_browse_behaviour_mark_before,
#后12
t2.browse_days_after,
t2.min_browse_time_after,
t2.max_browse_time_after,
t2.bias_browse_time_after,
t2.browse_hehaviour_types_after,
t2.max_browse_behaviour_after,
t2.min_browse_behaviour_after,
t2.mean_browse_behaviour_after,
t2.browse_hehaviour_mark_types_after,
t2.max_browse_behaviour_mark_after,
t2.min_browse_behaviour_mark_after,
t2.mean_browse_behaviour_mark_after
from
features_browse_0_before as t1,
features_browse_0_after as t2,
userid_predict_final as t3
where
(t3.user_id=t1.user_id)
and
(t3.user_id=t2.user_id)
);
###########################################################################
#############################################################################
#############################################################################
#交叉
#共48：
#前12，后12，
#交叉：均值12，bias12；
drop table if exists features_browse_1;
create table features_browse_1
(
select
t1.user_id,
#前：12+后：12 =24
t1.browse_days_before,
t1.min_browse_time_before,
t1.max_browse_time_before,
t1.bias_browse_time_before,
t1.browse_hehaviour_types_before,
t1.max_browse_behaviour_before,
t1.min_browse_behaviour_before,
t1.mean_browse_behaviour_before,
t1.browse_hehaviour_mark_types_before,
t1.max_browse_behaviour_mark_before,
t1.min_browse_behaviour_mark_before,
t1.mean_browse_behaviour_mark_before,
t1.browse_days_after,
t1.min_browse_time_after,
t1.max_browse_time_after,
t1.bias_browse_time_after,
t1.browse_hehaviour_types_after,
t1.max_browse_behaviour_after,
t1.min_browse_behaviour_after,
t1.mean_browse_behaviour_after,
t1.browse_hehaviour_mark_types_after,
t1.max_browse_behaviour_mark_after,
t1.min_browse_behaviour_mark_after,
t1.mean_browse_behaviour_mark_after,
#交叉
#均值：12；
(t1.browse_days_before+t1.browse_days_after)/2.0 as mean_1,
(t1.min_browse_time_before+t1.min_browse_time_after)/2.0 as mean_2,
(t1.max_browse_time_before+t1.max_browse_time_after)/2.0 as mean_3,
(t1.bias_browse_time_before+t1.bias_browse_time_after)/2.0 as mean_4,
(t1.browse_hehaviour_types_before+t1.browse_hehaviour_types_after)/2.0 as mean_5,
(t1.max_browse_behaviour_before+t1.max_browse_behaviour_after)/2.0 as mean_6,
(t1.min_browse_behaviour_before+t1.min_browse_behaviour_after)/2.0 as mean_7,
(t1.mean_browse_behaviour_before+t1.mean_browse_behaviour_after)/2.0 as mean_8,
(t1.browse_hehaviour_mark_types_before+t1.browse_hehaviour_mark_types_after)/2.0 as mean_9,
(t1.max_browse_behaviour_mark_before+t1.max_browse_behaviour_mark_after)/2.0 as mean_10,
(t1.min_browse_behaviour_mark_before+t1.min_browse_behaviour_mark_after)/2.0 as mean_11,
(t1.mean_browse_behaviour_mark_before+t1.mean_browse_behaviour_mark_after)/2.0 as mean_12,
#bias:12;
(t1.browse_days_before-t1.browse_days_after) as bias_1,
(t1.min_browse_time_before-t1.min_browse_time_after)as bias_2,
(t1.max_browse_time_before-t1.max_browse_time_after)as bias_3,
(t1.bias_browse_time_before-t1.bias_browse_time_after)as bias_4,
(t1.browse_hehaviour_types_before-t1.browse_hehaviour_types_after)as bias_5,
(t1.max_browse_behaviour_before-t1.max_browse_behaviour_after)as bias_6,
(t1.min_browse_behaviour_before-t1.min_browse_behaviour_after)as bias_7,
(t1.mean_browse_behaviour_before-t1.mean_browse_behaviour_after)as bias_8,
(t1.browse_hehaviour_mark_types_before-t1.browse_hehaviour_mark_types_after)as bias_9,
(t1.max_browse_behaviour_mark_before-t1.max_browse_behaviour_mark_after)as bias_10,
(t1.min_browse_behaviour_mark_before-t1.min_browse_behaviour_mark_after)as bias_11,
(t1.mean_browse_behaviour_mark_before-t1.mean_browse_behaviour_mark_after)as bias_12
from
features_browse_0 as t1
)
;