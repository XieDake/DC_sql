use training;
#提取用户贷前每月的消费特征！
#暂时18维！
drop table if exists features_2_later;
create table features_2_later
(
user_id int(20) not null,
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
consumed_rate float not null default 0
)
;
#insert
insert into features_2_later
(
select
t1.user_id,
#18
avg(t1.consume_times),
max(t1.consume_times),
min(t1.consume_times),
avg(t1.benqizhangdanyue),
max(t1.benqizhangdanyue),
min(t1.benqizhangdanyue),
avg(t1.benqizhangdanjine),
max(t1.benqizhangdanjine),
min(t1.benqizhangdanjine),
sum(t1.benqizhangdanyue)-sum(t1.benqizhangdanjine),
avg(t1.available_money),
max(t1.available_money),
min(t1.available_money),
avg(t1.adjust_money),
max(t1.adjust_money),
min(t1.adjust_money),
sum(t1.benqizhangdanjine)-sum(t1.adjust_money),
(sum(t1.benqizhangdanjine)-sum(t1.adjust_money))/(sum(t1.benqizhangdanyue)+0.00000000001)
from
bill_detail_new_final as t1,
loan_time_new_final as t2
where
(t1.user_id=t2.user_id)
and
(t1.bill_time_stamp>t2.loan_time)
#对where后的结果进行group by
group by t1.user_id
);
#防止除0，处理！update!
update features_2_later
#1个rate
set consumed_rate=0
where consumed_rate>100000000;
#feature_2 id补齐！
insert into features_2_later (features_2_later.user_id)
(#返回overdue中有但是features中没有的user！
select distinct(t1.user_id) from overdue_new_final as t1
where
(t1.user_id not in (select distinct(user_id) from features_2_later))
);
