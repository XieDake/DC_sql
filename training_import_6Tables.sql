use training;
#把所有的数据表先建好数据库！注意默认值设定,先不默认了！！
#把所有的数据表先建好数据库！注意默认值设定,先不默认了！！
#6个表！training！
#用户属性表：6字段！
create table userinfo
(
user_id int(20),
sex_type int(10),
occupation int(10),
education int(10),
marriage int(10),
person_type int(10)
);
#银行流水记录:5字段！
create table bank_Detail
(
user_id int(20),
Time_stamp bigint,
trade_type int(10),
trade_money float,
salary_mark int(10)
);
#用户浏览记录:4字段！
create table browse_history
(
user_id int(20),
Time_stamp bigint,
browse_behaviour int(10),
browse_behaviour_mark int(10)
);
#信用卡账单记录：15字段！表示一个周期内的结果统计！
create table bill_detail
(
user_id int(20),
bill_time_stamp bigint,
Bank_id int(10),
lastTime_moneyUsing float,
lastTime_moneyReturn float,
Credit_limit float,
benqizhangdanyue float,#本期账单余额=本期账单金额-已还的钱！就是下一期你需要还的钱（它还产生利息咯！）
benqizuidihuankuanjine float,#如果手头紧，本次你最少应还的钱！
consume_times int(10),
benqizhangdanjine float,#本期内你需要总的还的钱！
adjust_money float,#多还的钱!
cycle_interist float,#循环利息！
available_money float,#可用金额！可用信用额度！
advance_borrow_money float,#预借现金金额！信用卡取现的额度！
Moneyback_status int(10)
);
#放款时间信息：2字段！
create table loan_time
(
user_id int(20),
loan_time bigint
);
#顾客是否发生逾期行为记录:2字段！
create table overdue
(
user_id int(20),
lable int(10)
)