use testing;
#1:userinfo
drop table if exists userinfo_new_final;
create table userinfo_new_final
(
select distinct * from userinfo
);
#2:bank_detail
drop table if exists bank_detail_new_final;
create table bank_detail_new_final
(
select distinct * from bank_detail
);
#3:browse_history
drop table if exists browse_history_new_final;
create table browse_history_new_final
(
select distinct * from browse_history
);
#4:bill_detaill
drop table if exists bill_detail_new_final;
create table bill_detail_new_final
(
select distinct * from bill_detail
);
#5:loan_time
drop table if exists loan_time_new_final;
create table loan_time_new_final
(
select distinct * from loan_time
);
#6:userID_predict
drop table if exists userID_predict_final;
create table userID_predict_final
(
select distinct * from userID_predict
);