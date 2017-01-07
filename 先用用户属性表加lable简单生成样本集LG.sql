#training
use training;
create table trainingSet_0
(select 
b1.user_id as user_id,b1.sex_type as sex_type,b1.occupation as occupation,b1.education as education,b1.marriage as marriage,b1.person_type as person_type,
b2.lable as lable
from userinfo as b1,overdue as b2
where b1.user_id=b2.user_id
order by user_id
);
#testing
use testing;
create table testingSet_0
(select 
b1.user_id as user_id,b1.sex_type as sex_type,b1.occupation as occupation,b1.education as education,b1.marriage as marriage,b1.person_type as person_type
from userinfo as b1,userid_predict as b2
where b1.user_id=b2.user_id
order by user_id
);
#分正负样本吧！
use training;
create table Training_positive_0(
select * from trainingset_0 where lable=0
);
create table Training_negtive_0(
select * from trainingset_0 where lable=1
);
