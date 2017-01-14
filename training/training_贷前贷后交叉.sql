use training;
#总共：52*3+2=158维特征！
#贷前贷后交叉特征！
#贷前52，贷后也52
#交叉：
#1）各项对应均值：（贷前+贷后）/2,话说有些项不应该这么整！比如说贷前贷后时间差就不应该这么处理！
#2）各项对应的差：（贷前-贷后）！
#3）各项对应的变化率：（差）/均值！
#4) 单独把时间特征弄出来两列！
#总共：52*3+2=158维特征！
#建表：
drop table if exists features_credit_0;
create table features_credit_0
(
user_id int(20) not null,
#1）各项对应均值：（贷前+贷后）/2；—67-15=52维：
#21: features_1
avg_credit_card_numbers int(10) not null default 0,#0.018
avg_mean_credit_limit float not null default 0,#0.057
avg_max_credit_limit float not null default 0,#0.038
avg_min_credit_limit float not null default 0,#0.020
avg_s_1_times int(10) not null default 0,#0.00014
avg_s_1_times_prob float not null default 0,#0.00035
avg_s_0_times int(10) not null default 0,#0.072
avg_s_0_times_prob float not null default 0,#0.0125
avg_mean_cycle_interest float not null default 0,#0.027
avg_max_cycle_interest float not null default 0,#0.027
avg_min_cycle_interest float not null default 0,#0.0018
avg_mean_zuidihuankuan float not null default 0,#0.085
avg_min_zuidihuankuan float not null default 0,#0.063
avg_max_zuidihuankuan float not null default 0,#0.09
avg_mean_moneyreturn_rate float not null default 0,#0.081
avg_mean_lastmoneyreturn float not null default 0,#0.060
avg_min_lastmoneyreturn float not null default 0,#0.017
avg_max_lastmoneyreturn float not null default 0,#0.066
avg_mean_lastmoneyuse float not null default 0,#0.051
avg_min_lastmoneyuse float not null default 0,#0.034
avg_max_lastmoneyuse float not null default 0,#0.061
#18:features_2
avg_mean_consume_numbers int(10) not null default 0,
avg_max_consume_numbers int(10) not null default 0,
avg_min_consume_numbers int(10) not null default 0,
avg_mean_yue float not null default 0,
avg_max_yue float not null default 0,
avg_min_yue float not null default 0,
avg_mean_jine float not null default 0,
avg_max_jine float not null default 0,
avg_min_jine float not null default 0,
avg_bias_jine_yue float not null default 0,
avg_mean_available float not null default 0,
avg_max_available float not null default 0,
avg_min_available float not null default 0,
avg_mean_adjust float not null default 0,
avg_max_adjust float not null default 0,
avg_min_adjust float not null default 0,
avg_consumed_money float not null default 0,
avg_consumed_rate float not null default 0,
#13维！features_3
avg_time_creditUsing bigint not null default 0,
avg_mean_last_using_back float not null default 0,
avg_rate_consume_lastback float not null default 0,
avg_rate_consume_back float not null default 0,
avg_limit_lastusing float not null default 0,
avg_limit_thisusing float not null default 0,
avg_mean_thisneedback_thisusing float not null default 0,
avg_mean_consume float not null default 0,
avg_rate_consume_cycle float not null default 0,
avg_rate_consumetimes_cycle float not null default 0,
avg_rate_cycle_limit float not null default 0,
avg_rate_consume_limit float not null default 0,
avg_rate_lastback_limit float not null default 0,

#2）各项对应的差：（贷前-贷后）！
#21: features_1
bias_credit_card_numbers int(10) not null default 0,#0.018
bias_mean_credit_limit float not null default 0,#0.057
bias_max_credit_limit float not null default 0,#0.038
bias_min_credit_limit float not null default 0,#0.020
bias_s_1_times int(10) not null default 0,#0.00014
bias_s_1_times_prob float not null default 0,#0.00035
bias_s_0_times int(10) not null default 0,#0.072
bias_s_0_times_prob float not null default 0,#0.0125
bias_mean_cycle_interest float not null default 0,#0.027
bias_max_cycle_interest float not null default 0,#0.027
bias_min_cycle_interest float not null default 0,#0.0018
bias_mean_zuidihuankuan float not null default 0,#0.085
bias_min_zuidihuankuan float not null default 0,#0.063
bias_max_zuidihuankuan float not null default 0,#0.09
bias_mean_moneyreturn_rate float not null default 0,#0.081bias_
bias_mean_lastmoneyreturn float not null default 0,#0.060
bias_min_lastmoneyreturn float not null default 0,#0.017
bias_max_lastmoneyreturn float not null default 0,#0.066
bias_mean_lastmoneyuse float not null default 0,#0.051
bias_min_lastmoneyuse float not null default 0,#0.034
bias_max_lastmoneyuse float not null default 0,#0.061
#18:features_2
bias_mean_consume_numbers int(10) not null default 0,
bias_max_consume_numbers int(10) not null default 0,
bias_min_consume_numbers int(10) not null default 0,
bias_mean_yue float not null default 0,
bias_max_yue float not null default 0,
bias_min_yue float not null default 0,
bias_mean_jine float not null default 0,
bias_max_jine float not null default 0,
bias_min_jine float not null default 0,
bias_bias_jine_yue float not null default 0,
bias_mean_available float not null default 0,
bias_max_available float not null default 0,
bias_min_available float not null default 0,
bias_mean_adjust float not null default 0,
bias_max_adjust float not null default 0,
bias_min_adjust float not null default 0,
bias_consumed_money float not null default 0,
bias_consumed_rate float not null default 0,
#13:features_3
bias_time_creditUsing bigint not null default 0,
bias_mean_last_using_back float not null default 0,
bias_rate_consume_lastback float not null default 0,
bias_rate_consume_back float not null default 0,
bias_limit_lastusing float not null default 0,
bias_limit_thisusing float not null default 0,
bias_mean_thisneedback_thisusing float not null default 0,
bias_mean_consume float not null default 0,
bias_rate_consume_cycle float not null default 0,
bias_rate_consumetimes_cycle float not null default 0,
bias_rate_cycle_limit float not null default 0,
bias_rate_consume_limit float not null default 0,
bias_rate_lastback_limit float not null default 0,

#3）各项对应的变化率：（差）/均值！52维！
#21: features_1
changeRate_credit_card_numbers int(10) not null default 0,#0.018
changeRate_mean_credit_limit float not null default 0,#0.057
changeRate_max_credit_limit float not null default 0,#0.038
changeRate_min_credit_limit float not null default 0,#0.020
changeRate_s_1_times int(10) not null default 0,#0.00014
changeRate_s_1_times_prob float not null default 0,#0.00035
changeRate_s_0_times int(10) not null default 0,#0.072
changeRate_s_0_times_prob float not null default 0,#0.0125
changeRate_mean_cycle_interest float not null default 0,#0.027
changeRate_max_cycle_interest float not null default 0,#0.027
changeRate_min_cycle_interest float not null default 0,#0.0018
changeRate_mean_zuidihuankuan float not null default 0,#0.085
changeRate_min_zuidihuankuan float not null default 0,#0.063
changeRate_max_zuidihuankuan float not null default 0,#0.09
changeRate_mean_moneyreturn_rate float not null default 0,#0.081
changeRate_mean_lastmoneyreturn float not null default 0,#0.060
changeRate_min_lastmoneyreturn float not null default 0,#0.017
changeRate_max_lastmoneyreturn float not null default 0,#0.066
changeRate_mean_lastmoneyuse float not null default 0,#0.051
changeRate_min_lastmoneyuse float not null default 0,#0.034
changeRate_max_lastmoneyuse float not null default 0,#0.061
#18:features_2
changeRate_mean_consume_numbers int(10) not null default 0,
changeRate_max_consume_numbers int(10) not null default 0,
changeRate_min_consume_numbers int(10) not null default 0,
changeRate_mean_yue float not null default 0,
changeRate_max_yue float not null default 0,
changeRate_min_yue float not null default 0,
changeRate_mean_jine float not null default 0,
changeRate_max_jine float not null default 0,
changeRate_min_jine float not null default 0,
changeRate_bias_jine_yue float not null default 0,
changeRate_mean_available float not null default 0,
changeRate_max_available float not null default 0,
changeRate_min_available float not null default 0,
changeRate_mean_adjust float not null default 0,
changeRate_max_adjust float not null default 0,
changeRate_min_adjust float not null default 0,
changeRate_consumed_money float not null default 0,
changeRate_consumed_rate float not null default 0,
#13:features_3
changeRate_time_creditUsing bigint not null default 0,
changeRate_mean_last_using_back float not null default 0,
changeRate_rate_consume_lastback float not null default 0,
changeRate_rate_consume_back float not null default 0,
changeRate_limit_lastusing float not null default 0,
changeRate_limit_thisusing float not null default 0,
changeRate_mean_thisneedback_thisusing float not null default 0,
changeRate_mean_consume float not null default 0,
changeRate_rate_consume_cycle float not null default 0,
changeRate_rate_consumetimes_cycle float not null default 0,
changeRate_rate_cycle_limit float not null default 0,
changeRate_rate_consume_limit float not null default 0,
changeRate_rate_lastback_limit float not null default 0,
#单独把时间特征弄两列！
loanBefore_CreditUsingTime bigint not null default 0,
loanAfter_CreditUsingTime bigint not null default 0
);
#insert
insert into features_credit_0
(
select
t1.user_id,
##1）各项对应均值：（贷前+贷后）/2；—67-15=52维：
#21: features_1:t1/t1_l
(t1.credit_card_numbers+t1_l.credit_card_numbers)/2.0,
(t1.mean_credit_limit+t1_l.mean_credit_limit)/2.0,
(t1.max_credit_limit+t1_l.max_credit_limit)/2.0,
(t1.min_credit_limit+t1_l.min_credit_limit)/2.0,
(t1.s_1_times+t1_l.s_1_times)/2.0,
(t1.s_1_times_prob+t1_l.s_1_times_prob)/2.0,
(t1.s_0_times+t1_l.s_0_times)/2.0,
(t1.s_0_times_prob+t1_l.s_0_times_prob)/2.0,
(t1.mean_cycle_interest+t1_l.mean_cycle_interest)/2.0,
(t1.max_cycle_interest+t1_l.max_cycle_interest)/2.0,
(t1.min_cycle_interest+t1_l.min_cycle_interest)/2.0,
(t1.mean_zuidihuankuan+t1_l.mean_zuidihuankuan)/2.0,
(t1.min_zuidihuankuan+t1_l.min_zuidihuankuan)/2.0,
(t1.max_zuidihuankuan+t1_l.max_zuidihuankuan)/2.0,
(t1.mean_moneyreturn_rate+t1_l.mean_moneyreturn_rate)/2.0,
(t1.mean_lastmoneyreturn+t1_l.mean_lastmoneyreturn)/2.0,
(t1.min_lastmoneyreturn+t1_l.min_lastmoneyreturn)/2.0,
(t1.max_lastmoneyreturn+t1_l.max_lastmoneyreturn)/2.0,
(t1.mean_lastmoneyuse+t1_l.mean_lastmoneyuse)/2.0,
(t1.min_lastmoneyuse+t1_l.min_lastmoneyuse)/2.0,
(t1.max_lastmoneyuse+t1_l.max_lastmoneyuse)/2.0,
#18:features_2:t2/t2_l
(t2.mean_consume_numbers+t2_l.mean_consume_numbers)/2.0,
(t2.max_consume_numbers+t2_l.max_consume_numbers)/2.0,
(t2.min_consume_numbers+t2_l.min_consume_numbers)/2.0,
(t2.mean_yue+t2_l.mean_yue)/2.0,
(t2.max_yue+t2_l.max_yue)/2.0,
(t2.min_yue+t2_l.min_yue)/2.0,
(t2.mean_jine+t2_l.mean_jine)/2.0,
(t2.max_jine+t2_l.max_jine)/2.0,
(t2.min_jine+t2_l.min_jine)/2.0,
(t2.bias_jine_yue+t2_l.bias_jine_yue)/2.0,
(t2.mean_available+t2_l.mean_available)/2.0,
(t2.max_available+t2_l.max_available)/2.0,
(t2.min_available+t2_l.min_available)/2.0,
(t2.mean_adjust+t2_l.mean_adjust)/2.0,
(t2.max_adjust+t2_l.max_adjust)/2.0,
(t2.min_adjust+t2_l.min_adjust)/2.0,
(t2.consumed_money+t2_l.consumed_money)/2.0,
(t2.consumed_rate+t2_l.consumed_rate)/2.0,
#13:features_3:t3/t3_l
(t3.time_creditUsing+t3_l.time_creditUsing)/2.0,
(t3.mean_last_using_back+t3_l.mean_last_using_back)/2.0,
(t3.rate_consume_lastback+t3_l.rate_consume_lastback)/2.0,
(t3.rate_consume_back+t3_l.rate_consume_back)/2.0,
(t3.limit_lastusing+t3_l.limit_lastusing)/2.0,
(t3.limit_thisusing+t3_l.limit_thisusing)/2.0,
(t3.mean_thisneedback_thisusing+t3_l.mean_thisneedback_thisusing)/2.0,
(t3.mean_consume+t3_l.mean_consume)/2.0,
(t3.rate_consume_cycle+t3_l.rate_consume_cycle)/2.0,
(t3.rate_consumetimes_cycle+t3_l.rate_consumetimes_cycle)/2.0,
(t3.rate_cycle_limit+t3_l.rate_cycle_limit)/2.0,
(t3.rate_consume_limit+t3_l.rate_consume_limit)/2.0,
(t3.rate_lastback_limit+t3_l.rate_lastback_limit)/2.0,

#2）各项对应的差：（贷前-贷后）！
#21: features_1:t1/t1_l
(t1.credit_card_numbers-t1_l.credit_card_numbers),
(t1.mean_credit_limit-t1_l.mean_credit_limit),
(t1.max_credit_limit-t1_l.max_credit_limit),
(t1.min_credit_limit-t1_l.min_credit_limit),
(t1.s_1_times-t1_l.s_1_times),
(t1.s_1_times_prob-t1_l.s_1_times_prob),
(t1.s_0_times-t1_l.s_0_times),
(t1.s_0_times_prob-t1_l.s_0_times_prob),
(t1.mean_cycle_interest-t1_l.mean_cycle_interest),
(t1.max_cycle_interest-t1_l.max_cycle_interest),
(t1.min_cycle_interest-t1_l.min_cycle_interest),
(t1.mean_zuidihuankuan-t1_l.mean_zuidihuankuan),
(t1.min_zuidihuankuan-t1_l.min_zuidihuankuan),
(t1.max_zuidihuankuan-t1_l.max_zuidihuankuan),
(t1.mean_moneyreturn_rate-t1_l.mean_moneyreturn_rate),
(t1.mean_lastmoneyreturn-t1_l.mean_lastmoneyreturn),
(t1.min_lastmoneyreturn-t1_l.min_lastmoneyreturn),
(t1.max_lastmoneyreturn-t1_l.max_lastmoneyreturn),
(t1.mean_lastmoneyuse-t1_l.mean_lastmoneyuse),
(t1.min_lastmoneyuse-t1_l.min_lastmoneyuse),
(t1.max_lastmoneyuse-t1_l.max_lastmoneyuse),
#18:features_2:t2/t2_l
(t2.mean_consume_numbers-t2_l.mean_consume_numbers),
(t2.max_consume_numbers-t2_l.max_consume_numbers),
(t2.min_consume_numbers-t2_l.min_consume_numbers),
(t2.mean_yue-t2_l.mean_yue),
(t2.max_yue-t2_l.max_yue),
(t2.min_yue-t2_l.min_yue),
(t2.mean_jine-t2_l.mean_jine),
(t2.max_jine-t2_l.max_jine),
(t2.min_jine-t2_l.min_jine),
(t2.bias_jine_yue-t2_l.bias_jine_yue),
(t2.mean_available-t2_l.mean_available),
(t2.max_available-t2_l.max_available),
(t2.min_available-t2_l.min_available),
(t2.mean_adjust-t2_l.mean_adjust),
(t2.max_adjust-t2_l.max_adjust),
(t2.min_adjust-t2_l.min_adjust),
(t2.consumed_money-t2_l.consumed_money),
(t2.consumed_rate-t2_l.consumed_rate),
#13:features_3:t3/t3_l
(t3.time_creditUsing-t3_l.time_creditUsing),
(t3.mean_last_using_back-t3_l.mean_last_using_back),
(t3.rate_consume_lastback-t3_l.rate_consume_lastback),
(t3.rate_consume_back-t3_l.rate_consume_back),
(t3.limit_lastusing-t3_l.limit_lastusing),
(t3.limit_thisusing-t3_l.limit_thisusing),
(t3.mean_thisneedback_thisusing-t3_l.mean_thisneedback_thisusing),
(t3.mean_consume-t3_l.mean_consume),
(t3.rate_consume_cycle-t3_l.rate_consume_cycle),
(t3.rate_consumetimes_cycle-t3_l.rate_consumetimes_cycle),
(t3.rate_cycle_limit-t3_l.rate_cycle_limit),
(t3.rate_consume_limit-t3_l.rate_consume_limit),
(t3.rate_lastback_limit-t3_l.rate_lastback_limit),

#3）各项对应的变化率：（差）/均值！52维！
#21: features_1:t1/t1_l
(t1.credit_card_numbers-t1_l.credit_card_numbers)/((t1.credit_card_numbers+t1_l.credit_card_numbers)/2.0+0.00000000001),
(t1.mean_credit_limit-t1_l.mean_credit_limit)/((t1.mean_credit_limit+t1_l.mean_credit_limit)/2.0+0.00000000001),
(t1.max_credit_limit-t1_l.max_credit_limit)/((t1.max_credit_limit+t1_l.max_credit_limit)/2.0+0.00000000001),
(t1.min_credit_limit-t1_l.min_credit_limit)/((t1.min_credit_limit+t1_l.min_credit_limit)/2.0+0.00000000001),
(t1.s_1_times-t1_l.s_1_times)/((t1.s_1_times+t1_l.s_1_times)/2.0+0.00000000001),
(t1.s_1_times_prob-t1_l.s_1_times_prob)/((t1.s_1_times_prob+t1_l.s_1_times_prob)/2.0+0.00000000001),
(t1.s_0_times-t1_l.s_0_times)/((t1.s_0_times+t1_l.s_0_times)/2.0+0.00000000001),
(t1.s_0_times_prob-t1_l.s_0_times_prob)/((t1.s_0_times_prob+t1_l.s_0_times_prob)/2.0+0.00000000001),
(t1.mean_cycle_interest-t1_l.mean_cycle_interest)/((t1.mean_cycle_interest+t1_l.mean_cycle_interest)/2.0+0.00000000001),
(t1.max_cycle_interest-t1_l.max_cycle_interest)/((t1.max_cycle_interest+t1_l.max_cycle_interest)/2.0+0.00000000001),
(t1.min_cycle_interest-t1_l.min_cycle_interest)/((t1.min_cycle_interest+t1_l.min_cycle_interest)/2.0+0.00000000001),
(t1.mean_zuidihuankuan-t1_l.mean_zuidihuankuan)/((t1.mean_zuidihuankuan+t1_l.mean_zuidihuankuan)/2.0+0.00000000001),
(t1.min_zuidihuankuan-t1_l.min_zuidihuankuan)/((t1.min_zuidihuankuan+t1_l.min_zuidihuankuan)/2.0+0.00000000001),
(t1.max_zuidihuankuan-t1_l.max_zuidihuankuan)/((t1.max_zuidihuankuan+t1_l.max_zuidihuankuan)/2.0+0.00000000001),
(t1.mean_moneyreturn_rate-t1_l.mean_moneyreturn_rate)/((t1.mean_moneyreturn_rate+t1_l.mean_moneyreturn_rate)/2.0+0.00000000001),
(t1.mean_lastmoneyreturn-t1_l.mean_lastmoneyreturn)/((t1.mean_lastmoneyreturn+t1_l.mean_lastmoneyreturn)/2.0+0.00000000001),
(t1.min_lastmoneyreturn-t1_l.min_lastmoneyreturn)/((t1.min_lastmoneyreturn+t1_l.min_lastmoneyreturn)/2.0+0.00000000001),
(t1.max_lastmoneyreturn-t1_l.max_lastmoneyreturn)/((t1.max_lastmoneyreturn+t1_l.max_lastmoneyreturn)/2.0+0.00000000001),
(t1.mean_lastmoneyuse-t1_l.mean_lastmoneyuse)/((t1.mean_lastmoneyuse+t1_l.mean_lastmoneyuse)/2.0+0.00000000001),
(t1.min_lastmoneyuse-t1_l.min_lastmoneyuse)/((t1.min_lastmoneyuse+t1_l.min_lastmoneyuse)/2.0+0.00000000001),
(t1.max_lastmoneyuse-t1_l.max_lastmoneyuse)/((t1.max_lastmoneyuse+t1_l.max_lastmoneyuse)/2.0+0.00000000001),
#18:features_2:t2/t2_l
(t2.mean_consume_numbers-t2_l.mean_consume_numbers)/((t2.mean_consume_numbers+t2_l.mean_consume_numbers)/2.0+0.00000000001),
(t2.max_consume_numbers-t2_l.max_consume_numbers)/((t2.max_consume_numbers+t2_l.max_consume_numbers)/2.0+0.00000000001),
(t2.min_consume_numbers-t2_l.min_consume_numbers)/((t2.min_consume_numbers+t2_l.min_consume_numbers)/2.0+0.00000000001),
(t2.mean_yue-t2_l.mean_yue)/((t2.mean_yue+t2_l.mean_yue)/2.0+0.00000000001),
(t2.max_yue-t2_l.max_yue)/((t2.max_yue+t2_l.max_yue)/2.0+0.00000000001),
(t2.min_yue-t2_l.min_yue)/((t2.min_yue+t2_l.min_yue)/2.0+0.00000000001),
(t2.mean_jine-t2_l.mean_jine)/((t2.mean_jine+t2_l.mean_jine)/2.0+0.00000000001),
(t2.max_jine-t2_l.max_jine)/((t2.max_jine+t2_l.max_jine)/2.0+0.00000000001),
(t2.min_jine-t2_l.min_jine)/((t2.min_jine+t2_l.min_jine)/2.0+0.00000000001),
(t2.bias_jine_yue-t2_l.bias_jine_yue)/((t2.bias_jine_yue+t2_l.bias_jine_yue)/2.0+0.00000000001),
(t2.mean_available-t2_l.mean_available)/((t2.mean_available+t2_l.mean_available)/2.0+0.00000000001),
(t2.max_available-t2_l.max_available)/((t2.max_available+t2_l.max_available)/2.0+0.00000000001),
(t2.min_available-t2_l.min_available)/((t2.min_available+t2_l.min_available)/2.0+0.00000000001),
(t2.mean_adjust-t2_l.mean_adjust)/((t2.mean_adjust+t2_l.mean_adjust)/2.0+0.00000000001),
(t2.max_adjust-t2_l.max_adjust)/((t2.max_adjust+t2_l.max_adjust)/2.0+0.00000000001),
(t2.min_adjust-t2_l.min_adjust)/((t2.min_adjust+t2_l.min_adjust)/2.0+0.00000000001),
(t2.consumed_money-t2_l.consumed_money)/((t2.consumed_money+t2_l.consumed_money)/2.0+0.00000000001),
(t2.consumed_rate-t2_l.consumed_rate)/((t2.consumed_rate+t2_l.consumed_rate)/2.0+0.00000000001),
#13:features_3:t3/t3_l
(t3.time_creditUsing-t3_l.time_creditUsing)/((t3.time_creditUsing+t3_l.time_creditUsing)/2.0+0.00000000001),
(t3.mean_last_using_back-t3_l.mean_last_using_back)/((t3.mean_last_using_back+t3_l.mean_last_using_back)/2.0+0.00000000001),
(t3.rate_consume_lastback-t3_l.rate_consume_lastback)/((t3.rate_consume_lastback+t3_l.rate_consume_lastback)/2.0+0.00000000001),
(t3.rate_consume_back-t3_l.rate_consume_back)/((t3.rate_consume_back+t3_l.rate_consume_back)/2.0+0.00000000001),
(t3.limit_lastusing-t3_l.limit_lastusing)/((t3.limit_lastusing+t3_l.limit_lastusing)/2.0+0.00000000001),
(t3.limit_thisusing-t3_l.limit_thisusing)/((t3.limit_thisusing+t3_l.limit_thisusing)/2.0+0.00000000001),
(t3.mean_thisneedback_thisusing-t3_l.mean_thisneedback_thisusing)/((t3.mean_thisneedback_thisusing+t3_l.mean_thisneedback_thisusing)/2.0+0.00000000001),
(t3.mean_consume-t3_l.mean_consume)/((t3.mean_consume+t3_l.mean_consume)/2.0+0.00000000001),
(t3.rate_consume_cycle-t3_l.rate_consume_cycle)/((t3.rate_consume_cycle+t3_l.rate_consume_cycle)/2.0+0.00000000001),
(t3.rate_consumetimes_cycle-t3_l.rate_consumetimes_cycle)/((t3.rate_consumetimes_cycle+t3_l.rate_consumetimes_cycle)/2.0+0.00000000001),
(t3.rate_cycle_limit-t3_l.rate_cycle_limit)/((t3.rate_cycle_limit+t3_l.rate_cycle_limit)/2.0+0.00000000001),
(t3.rate_consume_limit-t3_l.rate_consume_limit)/((t3.rate_consume_limit+t3_l.rate_consume_limit)/2.0+0.00000000001),
(t3.rate_lastback_limit-t3_l.rate_lastback_limit)/((t3.rate_lastback_limit+t3_l.rate_lastback_limit)/2.0+0.00000000001),

#另加两列！
t3.time_creditUsing,
t3_l.time_creditUsing
from
features_1 as t1,
features_1_later as t1_l,
features_2 as t2,
features_2_later as t2_l,
features_3 as t3,
features_3_later as t3_l
#条件！
where
(t1.user_id=t1_l.user_id)
and
(t1.user_id=t2.user_id)
and
(t1.user_id=t2_l.user_id)
and
(t1.user_id=t3.user_id)
and
(t1.user_id=t3_l.user_id)
);
#update！预防除0！
#52个，我擦！
#21: features_1
update features_credit_0
set changeRate_credit_card_numbers=0
where
changeRate_credit_card_numbers>100000000;

update features_credit_0
set changeRate_mean_credit_limit=0
where
changeRate_mean_credit_limit >100000000;

update features_credit_0
set changeRate_max_credit_limit=0
where
changeRate_max_credit_limit>100000000;

update features_credit_0
set changeRate_min_credit_limit=0
where
changeRate_min_credit_limit >100000000;

update features_credit_0
set changeRate_s_1_times=0
where
changeRate_s_1_times>100000000;

update features_credit_0
set changeRate_s_1_times_prob=0
where
changeRate_s_1_times_prob >100000000;

update features_credit_0
set changeRate_s_0_times=0
where
changeRate_s_0_times >100000000;

update features_credit_0
set changeRate_s_0_times_prob=0
where
changeRate_s_0_times_prob >100000000;

update features_credit_0
set changeRate_mean_cycle_interest=0
where
changeRate_mean_cycle_interest >100000000;

update features_credit_0
set changeRate_max_cycle_interest=0
where
changeRate_max_cycle_interest >100000000;

update features_credit_0
set changeRate_min_cycle_interest=0
where
changeRate_min_cycle_interest >100000000;

update features_credit_0
set changeRate_mean_zuidihuankuan=0
where
changeRate_mean_zuidihuankuan >100000000;

update features_credit_0
set changeRate_min_zuidihuankuan=0
where
changeRate_min_zuidihuankuan >100000000;

update features_credit_0
set changeRate_max_zuidihuankuan=0
where
changeRate_max_zuidihuankuan >100000000;

update features_credit_0
set changeRate_mean_moneyreturn_rate=0
where
changeRate_mean_moneyreturn_rate >100000000;

update features_credit_0
set changeRate_mean_lastmoneyreturn=0
where
changeRate_mean_lastmoneyreturn >100000000;

update features_credit_0
set changeRate_min_lastmoneyreturn=0
where
changeRate_min_lastmoneyreturn >100000000;

update features_credit_0
set changeRate_max_lastmoneyreturn=0
where
changeRate_max_lastmoneyreturn >100000000;

update features_credit_0
set changeRate_mean_lastmoneyuse=0
where
changeRate_mean_lastmoneyuse >100000000;

update features_credit_0
set changeRate_min_lastmoneyuse=0
where
changeRate_min_lastmoneyuse >100000000;

update features_credit_0
set changeRate_max_lastmoneyuse=0
where
changeRate_max_lastmoneyuse >100000000;
#18:features_2

update features_credit_0
set changeRate_mean_consume_numbers=0
where
changeRate_mean_consume_numbers >100000000;

update features_credit_0
set changeRate_max_consume_numbers=0
where
changeRate_max_consume_numbers >100000000;

update features_credit_0
set changeRate_min_consume_numbers=0
where
changeRate_min_consume_numbers >100000000;

update features_credit_0
set changeRate_mean_yue=0
where
changeRate_mean_yue >100000000;

update features_credit_0
set changeRate_max_yue=0
where
changeRate_max_yue >100000000;

update features_credit_0
set changeRate_min_yue=0
where
changeRate_min_yue >100000000;

update features_credit_0
set changeRate_mean_jine=0
where
changeRate_mean_jine >100000000;

update features_credit_0
set changeRate_max_jine=0
where
changeRate_max_jine >100000000;

update features_credit_0
set changeRate_min_jine=0
where
changeRate_min_jine >100000000;

update features_credit_0
set changeRate_bias_jine_yue=0
where
changeRate_bias_jine_yue >100000000;

update features_credit_0
set changeRate_mean_available=0
where
changeRate_mean_available >100000000;

update features_credit_0
set changeRate_max_available=0
where
changeRate_max_available >100000000;

update features_credit_0
set changeRate_min_available=0
where
changeRate_min_available >100000000;

update features_credit_0
set changeRate_mean_adjust=0
where
changeRate_mean_adjust >100000000;

update features_credit_0
set changeRate_max_adjust=0
where
changeRate_max_adjust >100000000;

update features_credit_0
set changeRate_min_adjust=0
where
changeRate_min_adjust >100000000;

update features_credit_0
set changeRate_consumed_money=0
where
changeRate_consumed_money >100000000;

update features_credit_0
set changeRate_consumed_rate=0
where
changeRate_consumed_rate >100000000;
#13:features_3

update features_credit_0
set changeRate_time_creditUsing=0
where
changeRate_time_creditUsing >100000000;

update features_credit_0
set changeRate_mean_last_using_back=0
where
changeRate_mean_last_using_back >100000000;

update features_credit_0
set changeRate_rate_consume_lastback=0
where
changeRate_rate_consume_lastback >100000000;

update features_credit_0
set changeRate_rate_consume_back=0
where
changeRate_rate_consume_back >100000000;

update features_credit_0
set changeRate_limit_lastusing=0
where
changeRate_limit_lastusing >100000000;

update features_credit_0
set changeRate_limit_thisusing=0
where
changeRate_limit_thisusing >100000000;

update features_credit_0
set changeRate_mean_thisneedback_thisusing=0
where
changeRate_mean_thisneedback_thisusing>100000000; 

update features_credit_0
set changeRate_mean_consume=0
where
changeRate_mean_consume >100000000;

update features_credit_0
set changeRate_rate_consume_cycle=0
where
changeRate_rate_consume_cycle >100000000;

update features_credit_0
set changeRate_rate_consumetimes_cycle=0
where
changeRate_rate_consumetimes_cycle >100000000;

update features_credit_0
set changeRate_rate_cycle_limit=0
where
changeRate_rate_cycle_limit >100000000;

update features_credit_0
set changeRate_rate_consume_limit=0
where
changeRate_rate_consume_limit>100000000;

update features_credit_0
set changeRate_rate_lastback_limit=0
where
changeRate_rate_lastback_limit>100000000;
