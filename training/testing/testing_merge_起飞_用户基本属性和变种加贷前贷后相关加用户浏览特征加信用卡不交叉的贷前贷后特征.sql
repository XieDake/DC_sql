use testing;
#这个表中主要是在上一次merge的203维特征的基础上进行新的特征的添加！
#感觉应该还需使用信用卡贷前贷后特征！而不只是使用交叉特征！
#这一次共有:203-25=178+52*2=282维特征！
#终于拿头敲开你的门！fighting！
#按照特征重要性去掉6维重要程度<=10^-5的特征!
#2：加入基于上述分析发现的时间特征的创造性添加一些特征（比较强力）12维！features_credit_1;
#features都是补齐过的！
drop table if exists training_merge_2017116;
create table training_merge_2017116
(
select
t6.user_id,
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
#这里还需添加贷前贷后相关的特征！104维特征！
#贷前52！
#21+18+13
t3.credit_card_numbers as credit_before_1,
t3.mean_credit_limit as credit_before_2,
t3.max_credit_limit as credit_before_3,
t3.min_credit_limit as credit_before_4,
t3.s_1_times as credit_before_5,
t3.s_1_times_prob as credit_before_6,
t3.s_0_times as credit_before_7,
t3.s_0_times_prob as credit_before_8,
t3.mean_cycle_interest as credit_before_9,
t3.max_cycle_interest as credit_before_10,
t3.min_cycle_interest as credit_before_11,
t3.mean_zuidihuankuan as credit_before_12,
t3.min_zuidihuankuan as credit_before_13,
t3.max_zuidihuankuan as credit_before_14,
t3.mean_moneyreturn_rate as credit_before_15,
t3.mean_lastmoneyreturn as credit_before_16,
t3.min_lastmoneyreturn as credit_before_17,
t3.max_lastmoneyreturn as credit_before_18,
t3.mean_lastmoneyuse as credit_before_19,
t3.min_lastmoneyuse as credit_before_20,
t3.max_lastmoneyuse as credit_before_21,
#
t4.mean_consume_numbers as credit_before_22,
t4.max_consume_numbers as credit_before_23,
t4.min_consume_numbers as credit_before_24,
t4.mean_yue as credit_before_25,
t4.max_yue as credit_before_26,
t4.min_yue as credit_before_27,
t4.mean_jine as credit_before_28,
t4.max_jine as credit_before_29,
t4.min_jine as credit_before_30,
t4.bias_jine_yue as credit_before_31,
t4.mean_available as credit_before_32,
t4.max_available as credit_before_33,
t4.min_available as credit_before_34,
t4.mean_adjust as credit_before_35,
t4.max_adjust as credit_before_36,
t4.min_adjust as credit_before_37,
t4.consumed_money as credit_before_38,
t4.consumed_rate as credit_before_39,
#
t5.time_creditUsing as credit_before_40,
t5.mean_last_using_back as credit_before_41,
t5.rate_consume_lastback as credit_before_42,
t5.rate_consume_back as credit_before_43,
t5.limit_lastusing as credit_before_44,
t5.limit_thisusing as credit_before_45,
t5.mean_thisneedback_thisusing as credit_before_46,
t5.mean_consume as credit_before_47,
t5.rate_consume_cycle as credit_before_48,
t5.rate_consumetimes_cycle as credit_before_49,
t5.rate_cycle_limit as credit_before_50,
t5.rate_consume_limit as credit_before_51,
t5.rate_lastback_limit as credit_before_52,
#贷后52！
#21+18+13
t3_l.credit_card_numbers as credit_after_1,
t3_l.mean_credit_limit as credit_after_2,
t3_l.max_credit_limit as credit_after_3,
t3_l.min_credit_limit as credit_after_4,
t3_l.s_1_times as credit_after_5,
t3_l.s_1_times_prob as credit_after_6,
t3_l.s_0_times as credit_after_7,
t3_l.s_0_times_prob as credit_after_8,
t3_l.mean_cycle_interest as credit_after_9,
t3_l.max_cycle_interest as credit_after_10,
t3_l.min_cycle_interest as credit_after_11,
t3_l.mean_zuidihuankuan as credit_after_12,
t3_l.min_zuidihuankuan as credit_after_13,
t3_l.max_zuidihuankuan as credit_after_14,
t3_l.mean_moneyreturn_rate as credit_after_15,
t3_l.mean_lastmoneyreturn as credit_after_16,
t3_l.min_lastmoneyreturn as credit_after_17,
t3_l.max_lastmoneyreturn as credit_after_18,
t3_l.mean_lastmoneyuse as credit_after_19,
t3_l.min_lastmoneyuse as credit_after_20,
t3_l.max_lastmoneyuse as credit_after_21,
#
t4_l.mean_consume_numbers as credit_after_22,
t4_l.max_consume_numbers as credit_after_23,
t4_l.min_consume_numbers as credit_after_24,
t4_l.mean_yue as credit_after_25,
t4_l.max_yue as credit_after_26,
t4_l.min_yue as credit_after_27,
t4_l.mean_jine as credit_after_28,
t4_l.max_jine as credit_after_29,
t4_l.min_jine as credit_after_30,
t4_l.bias_jine_yue as credit_after_31,
t4_l.mean_available as credit_after_32,
t4_l.max_available as credit_after_33,
t4_l.min_available as credit_after_34,
t4_l.mean_adjust as credit_after_35,
t4_l.max_adjust as credit_after_36,
t4_l.min_adjust as credit_after_37,
t4_l.consumed_money as credit_after_38,
t4_l.consumed_rate as credit_after_39,
#
t5_l.time_creditUsing as credit_after_40,
t5_l.mean_last_using_back as credit_after_41,
t5_l.rate_consume_lastback as credit_after_42,
t5_l.rate_consume_back as credit_after_43,
t5_l.limit_lastusing as credit_after_44,
t5_l.limit_thisusing as credit_after_45,
t5_l.mean_thisneedback_thisusing as credit_after_46,
t5_l.mean_consume as credit_after_47,
t5_l.rate_consume_cycle as credit_after_48,
t5_l.rate_consumetimes_cycle as credit_after_49,
t5_l.rate_cycle_limit as credit_after_50,
t5_l.rate_consume_limit as credit_after_51,
t5_l.rate_lastback_limit as credit_after_52,
#features_credit:132
#1）各项对应均值:46维：再去掉30,35=44
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
#t2.avg_max_adjust,
t2.avg_min_adjust,
t2.avg_consumed_money,
t2.avg_consumed_rate,
#13维！features_3
t2.avg_time_creditUsing,
#t2.avg_mean_last_using_back,
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
#2）各项对应的差：（贷前-贷后）！47,再去掉12！
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
#t2.bias_mean_lastmoneyreturn,#0.060
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
#3）各项对应的变化率：（差）/均值！
#34维去掉1,2,3,4,10,18,21,22,31,33======24维！
#21: features_1
#t2.changeRate_credit_card_numbers,#0.018
#t2.changeRate_mean_credit_limit,#0.057
#t2.changeRate_max_credit_limit,#0.038
#t2.changeRate_min_credit_limit,#0.020
#t2.changeRate_s_1_times,#0.00014
#t2.changeRate_s_1_times_prob,#0.00035
#t2.changeRate_s_0_times,#0.072
#t2.changeRate_s_0_times_prob,#0.0125
#t2.changeRate_mean_cycle_interest,#0.027
#t2.changeRate_max_cycle_interest,#0.027
#t2.changeRate_min_cycle_interest,#0.0018
t2.changeRate_mean_zuidihuankuan,#0.085
t2.changeRate_min_zuidihuankuan,#0.063
t2.changeRate_max_zuidihuankuan,#0.09
t2.changeRate_mean_moneyreturn_rate,#0.081
t2.changeRate_mean_lastmoneyreturn,#0.060
#t2.changeRate_min_lastmoneyreturn,#0.017
t2.changeRate_max_lastmoneyreturn,#0.066
t2.changeRate_mean_lastmoneyuse,#0.051
t2.changeRate_min_lastmoneyuse,#0.034
t2.changeRate_max_lastmoneyuse,#0.061
#18:features_2
t2.changeRate_mean_consume_numbers,
t2.changeRate_max_consume_numbers,
#t2.changeRate_min_consume_numbers,
t2.changeRate_mean_yue,
#t2.changeRate_max_yue,
t2.changeRate_min_yue,
#t2.changeRate_mean_jine,
t2.changeRate_max_jine,
#t2.changeRate_min_jine,
#t2.changeRate_bias_jine_yue,
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
#t2.changeRate_rate_consume_cycle,
t2.changeRate_rate_consumetimes_cycle,
#t2.changeRate_rate_cycle_limit,
#t2.changeRate_rate_consume_limit,
t2.changeRate_rate_lastback_limit,
#单独把时间特征弄两列！
t2.loanBefore_CreditUsingTime,
t2.loanAfter_CreditUsingTime,
#############################
############################
#以下是比较强力的12维特征！
#剩余11维
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
#12:去掉：10，11=10维！
t1.browse_days_before,
t1.min_browse_time_before,
t1.max_browse_time_before,
t1.bias_browse_time_before,
t1.browse_hehaviour_types_before,
t1.max_browse_behaviour_before,
t1.min_browse_behaviour_before,
t1.mean_browse_behaviour_before,
t1.browse_hehaviour_mark_types_before,
#t1.max_browse_behaviour_mark_before,
#t1.min_browse_behaviour_mark_before,
t1.mean_browse_behaviour_mark_before,
#12:去掉：2，3，4，6，10，11剩余6维！
t1.browse_days_after,
#t1.min_browse_time_after,
#t1.max_browse_time_after,
#t1.bias_browse_time_after,
t1.browse_hehaviour_types_after,
#t1.max_browse_behaviour_after,
t1.min_browse_behaviour_after,
t1.mean_browse_behaviour_after,
t1.browse_hehaviour_mark_types_after,
#t1.max_browse_behaviour_mark_after,
#t1.min_browse_behaviour_mark_after,
t1.mean_browse_behaviour_mark_after,
#交叉
#均值：12；去掉10，11剩余10维！
t1.mean_1,
t1.mean_2,
t1.mean_3,
t1.mean_4,
t1.mean_5,
t1.mean_6,
t1.mean_7,
t1.mean_8,
t1.mean_9,
#t1.mean_10,
#t1.mean_11,
t1.mean_12,
#bias:12;去掉：7，10，11剩余9维！
t1.bias_1,
t1.bias_2,
t1.bias_3,
t1.bias_4,
t1.bias_5,
t1.bias_6,
#t1.bias_7,
t1.bias_8,
t1.bias_9,
#t1.bias_10,
#t1.bias_11,
t1.bias_12
#lable
#t3.lable
from
features_browse_1 as t1,
training_merge_2017113 as t2,
features_1 as t3,
features_1_later as t3_l,
features_2 as t4,
features_2_later as t4_l,
features_3 as t5,
features_3_later as t5_l,
userid_predict_final as t6
where 
(t6.user_id=t1.user_id)
and
(t6.user_id=t2.user_id)
and
(t6.user_id=t3.user_id)
and
(t6.user_id=t3_l.user_id)
and
(t6.user_id=t4.user_id)
and
(t6.user_id=t4_l.user_id)
and
(t6.user_id=t5.user_id)
and
(t6.user_id=t5_l.user_id)
);