use training;
#load txt 文件导入数据库表中6个！
#1
load data local infile"F:/Desktop/DC2017/dataSet/train/user_info_train.txt"
into table userinfo
fields terminated by','
lines terminated by'\r\n'
;
#2
load data local infile"F:/Desktop/DC2017/dataSet/train/bank_detail_train.txt"
into table bank_detail
fields terminated by','
lines terminated by'\r\n'
;
#3
load data local infile"F:/Desktop/DC2017/dataSet/train/browse_history_train.txt"
into table browse_history
fields terminated by','
lines terminated by'\r\n'
;
#4
load data local infile"F:/Desktop/DC2017/dataSet/train/bill_detail_train.txt"
into table bill_detail
fields terminated by','
lines terminated by'\r\n'
;
#5
load data local infile"F:/Desktop/DC2017/dataSet/train/loan_time_train.txt"
into table loan_time
fields terminated by','
lines terminated by'\r\n'
;
#6
load data local infile"F:/Desktop/DC2017/dataSet/train/overdue_train.txt"
into table overdue
fields terminated by','
lines terminated by'\r\n'
;