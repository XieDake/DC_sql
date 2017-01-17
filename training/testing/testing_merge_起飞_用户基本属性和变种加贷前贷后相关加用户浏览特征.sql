use testing;
#这个表中主要是用户属性和变种特征！还有用户的信用卡特征！还有用户的浏览特征！
#这一次共有:161-6+48=203维特征！
#终于拿头敲开你的门！fighting！
#按照特征重要性去掉6维重要程度<=10^-5的特征!
#2：加入基于上述分析发现的时间特征的创造性添加一些特征（比较强力）12维！features_credit_1;
#features都是补齐过的！
drop table if exists training_merge_2017115;
create table training_merge_2017115
(
select
t3.user_id,
#t2:161=15+48+48+36+2+12
#161-6=155
#features_0:15
t2.sex_type,
t2.occupation,
t2.education,
t2.marriage,
t2.person_type, 
t2.sex_occupation,
t2.sex_education,
t2.sex_marriage,
t2.sex_persontype,
t2.occupation_education,
t2.occupation_marriage,
t2.occupation_persontype,
t2.education_marriage,
t2.education_persontype,
t2.marriage_persontype,
#features_credit:132
#1）各项对应均值:52-4=48维：
#再去掉8，21！
#21: features_1
t2.avg_credit_card_numbers,#0.018
t2.avg_mean_credit_limit,#0.057
t2.avg_max_credit_limit,#0.038
t2.avg_min_credit_limit,#0.020
#t2.avg_s_1_times,#0.00014
#t2.avg_s_1_times_prob,#0.00035
t2.avg_s_0_times,#0.072
#t2.avg_s_0_times_prob,#0.0125
t2.avg_mean_cycle_interest,#0.027
t2.avg_max_cycle_interest,#0.027
#t2.avg_min_cycle_interest,#0.0018
t2.avg_mean_zuidihuankuan,#0.085
t2.avg_min_zuidihuankuan,#0.063
t2.avg_max_zuidihuankuan,#0.09
t2.avg_mean_moneyreturn_rate,#0.081
t2.avg_mean_lastmoneyreturn,#0.060
t2.avg_min_lastmoneyreturn,#0.017
t2.avg_max_lastmoneyreturn,#0.066
t2.avg_mean_lastmoneyuse,#0.051
t2.avg_min_lastmoneyuse,#0.034
t2.avg_max_lastmoneyuse,#0.061
#18:features_2
t2.avg_mean_consume_numbers,
t2.avg_max_consume_numbers,
#t2.avg_min_consume_numbers,
t2.avg_mean_yue,
t2.avg_max_yue,
t2.avg_min_yue,
t2.avg_mean_jine,
t2.avg_max_jine,
t2.avg_min_jine,
t2.avg_bias_jine_yue,
t2.avg_mean_available,
t2.avg_max_available,
#t2.avg_min_available,
t2.avg_mean_adjust,
t2.avg_max_adjust,
t2.avg_min_adjust,
t2.avg_consumed_money,
t2.avg_consumed_rate,
#13维！features_3
t2.avg_time_creditUsing,
t2.avg_mean_last_using_back,
t2.avg_rate_consume_lastback,
t2.avg_rate_consume_back,
t2.avg_limit_lastusing,
t2.avg_limit_thisusing,
t2.avg_mean_thisneedback_thisusing,
t2.avg_mean_consume,
t2.avg_rate_consume_cycle,
t2.avg_rate_consumetimes_cycle,
t2.avg_rate_cycle_limit,
t2.avg_rate_consume_limit,
t2.avg_rate_lastback_limit,
#2）各项对应的差：（贷前-贷后）！52-4=48维！
#再去掉8！
#21: features_1
t2.bias_credit_card_numbers,#0.018
t2.bias_mean_credit_limit,#0.057
t2.bias_max_credit_limit,#0.038
t2.bias_min_credit_limit,#0.020
#t2.bias_s_1_times,#0.00014
#t2.bias_s_1_times_prob,#0.00035
t2.bias_s_0_times,#0.072
#t2.bias_s_0_times_prob,#0.0125
t2.bias_mean_cycle_interest,#0.027
t2.bias_max_cycle_interest,#0.027
#t2.bias_min_cycle_interest,#0.0018
t2.bias_mean_zuidihuankuan,#0.085
t2.bias_min_zuidihuankuan,#0.063
t2.bias_max_zuidihuankuan,#0.09
t2.bias_mean_moneyreturn_rate,#0.081bias_
t2.bias_mean_lastmoneyreturn,#0.060
t2.bias_min_lastmoneyreturn,#0.017
t2.bias_max_lastmoneyreturn,#0.066
t2.bias_mean_lastmoneyuse,#0.051
t2.bias_min_lastmoneyuse,#0.034
t2.bias_max_lastmoneyuse,#0.061
#18:features_2
t2.bias_mean_consume_numbers,
t2.bias_max_consume_numbers,
t2.bias_min_consume_numbers,
t2.bias_mean_yue,
t2.bias_max_yue,
t2.bias_min_yue,
t2.bias_mean_jine,
t2.bias_max_jine,
t2.bias_min_jine,
t2.bias_bias_jine_yue,
t2.bias_mean_available,
t2.bias_max_available,
#t2.bias_min_available,
t2.bias_mean_adjust,
t2.bias_max_adjust,
t2.bias_min_adjust,
t2.bias_consumed_money,
t2.bias_consumed_rate,
#13:features_3
t2.bias_time_creditUsing,
t2.bias_mean_last_using_back,
t2.bias_rate_consume_lastback,
t2.bias_rate_consume_back,
t2.bias_limit_lastusing,
t2.bias_limit_thisusing,
t2.bias_mean_thisneedback_thisusing,
t2.bias_mean_consume,
t2.bias_rate_consume_cycle,
t2.bias_rate_consumetimes_cycle,
t2.bias_rate_cycle_limit,
t2.bias_rate_consume_limit,
t2.bias_rate_lastback_limit,
#3）各项对应的变化率：（差）/均值！52-16=36维！
#再去掉3，6！
#21: features_1
t2.changeRate_credit_card_numbers,#0.018
t2.changeRate_mean_credit_limit,#0.057
#t2.changeRate_max_credit_limit,#0.038
t2.changeRate_min_credit_limit,#0.020
#t2.changeRate_s_1_times,#0.00014
#t2.changeRate_s_1_times_prob,#0.00035
#t2.changeRate_s_0_times,#0.072
#t2.changeRate_s_0_times_prob,#0.0125
#t2.changeRate_mean_cycle_interest,#0.027
t2.changeRate_max_cycle_interest,#0.027
#t2.changeRate_min_cycle_interest,#0.0018
t2.changeRate_mean_zuidihuankuan,#0.085
t2.changeRate_min_zuidihuankuan,#0.063
t2.changeRate_max_zuidihuankuan,#0.09
t2.changeRate_mean_moneyreturn_rate,#0.081
t2.changeRate_mean_lastmoneyreturn,#0.060
t2.changeRate_min_lastmoneyreturn,#0.017
t2.changeRate_max_lastmoneyreturn,#0.066
t2.changeRate_mean_lastmoneyuse,#0.051
t2.changeRate_min_lastmoneyuse,#0.034
t2.changeRate_max_lastmoneyuse,#0.061
#18:features_2
t2.changeRate_mean_consume_numbers,
t2.changeRate_max_consume_numbers,
#t2.changeRate_min_consume_numbers,
t2.changeRate_mean_yue,
t2.changeRate_max_yue,
t2.changeRate_min_yue,
#t2.changeRate_mean_jine,
t2.changeRate_max_jine,
t2.changeRate_min_jine,
t2.changeRate_bias_jine_yue,
#t2.changeRate_mean_available,
#t2.changeRate_max_available,
#t2.changeRate_min_available,
#t2.changeRate_mean_adjust,
#t2.changeRate_max_adjust,
#t2.changeRate_min_adjust,
t2.changeRate_consumed_money,
t2.changeRate_consumed_rate,
#13:features_3
#t2.changeRate_time_creditUsing,
t2.changeRate_mean_last_using_back,
t2.changeRate_rate_consume_lastback,
t2.changeRate_rate_consume_back,
t2.changeRate_limit_lastusing,
t2.changeRate_limit_thisusing,
t2.changeRate_mean_thisneedback_thisusing,
#t2.changeRate_mean_consume,
t2.changeRate_rate_consume_cycle,
t2.changeRate_rate_consumetimes_cycle,
#t2.changeRate_rate_cycle_limit,
t2.changeRate_rate_consume_limit,
t2.changeRate_rate_lastback_limit,
#单独把时间特征弄两列！
t2.loanBefore_CreditUsingTime,
t2.loanAfter_CreditUsingTime,
#############################
############################
#以下是比较强力的12维特征！
t2.credit_use_times_before,
t2.min_credit_time_use_before,
t2.max_credit_time_use_before,
t2.bias_credit_time_use_before,
t2.creditCard_active_before,
t2.credit_use_times_after,
t2.min_credit_time_use_after,
t2.max_credit_time_use_after,
t2.bias_credit_time_use_after,
#t3.creditCard_active_after,
t2.bias_1 as creditCard_bias1,
t2.bias_2 as creditCard_bias2,
####################
#再加新的48维浏览行为特征！
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
t1.mean_1,
t1.mean_2,
t1.mean_3,
t1.mean_4,
t1.mean_5,
t1.mean_6,
t1.mean_7,
t1.mean_8,
t1.mean_9,
t1.mean_10,
t1.mean_11,
t1.mean_12,
#bias:12;
t1.bias_1,
t1.bias_2,
t1.bias_3,
t1.bias_4,
t1.bias_5,
t1.bias_6,
t1.bias_7,
t1.bias_8,
t1.bias_9,
t1.bias_10,
t1.bias_11,
t1.bias_12
#lable
#t3.lable
from
features_browse_1 as t1,
training_merge_2017113 as t2,
userid_predict_final as t3
where 
(t3.user_id=t1.user_id)
and
(t3.user_id=t2.user_id)
);