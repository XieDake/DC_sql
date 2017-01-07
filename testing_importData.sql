use testing;
#load txt 文件导入数据库表中6个！
#1
load data local infile"F:/Desktop/DC2017/dataSet/test/user_info_test.txt"
into table userinfo
fields terminated by','
lines terminated by'\r\n'
;
#2
load data local infile"F:/Desktop/DC2017/dataSet/test/bank_detail_test.txt"
into table bank_detail
fields terminated by','
lines terminated by'\r\n'
;
#3
load data local infile"F:/Desktop/DC2017/dataSet/test/browse_history_test.txt"
into table browse_history
fields terminated by','
lines terminated by'\r\n'
;
#4
load data local infile"F:/Desktop/DC2017/dataSet/test/bill_detail_test.txt"
into table bill_detail
fields terminated by','
lines terminated by'\r\n'
;
#5
load data local infile"F:/Desktop/DC2017/dataSet/test/loan_time_test.txt"
into table loan_time
fields terminated by','
lines terminated by'\r\n'
;
#6
load data local infile"F:/Desktop/DC2017/dataSet/test/usersID_test.txt"
into table userid_predict
fields terminated by','
lines terminated by'\r\n'
;