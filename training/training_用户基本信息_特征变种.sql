use training;
#5维基本特征变种成10维特征！features_0
#建表
drop table if exists features_0;
create table features_0
(
user_id int(20) not null,
#用户基本属性！这个表是全的！非空即可！
#5维基本特征！
sex_type int(10) not null default 0,
occupation int(10)not null,
education int(10) not null,
marriage int(10) not null,
person_type int(10) not null, 
#10维变种特征！
sex_occupation float not null,
sex_education float not null,
sex_marriage float not null,
sex_persontype float not null,
occupation_education float not null,
occupation_marriage float not null,
occupation_persontype float not null,
education_marriage float not null,
education_persontype float not null,
marriage_persontype float not null
);
# insert,不用担心0的问题和id补齐问题！
insert into features_0
(
select 
t1.user_id,
#5维基本！
t1.sex_type,
t1.occupation,
t1.education,
t1.marriage,
t1.person_type,
#10维变种！
(t1.sex_type)*(t1.occupation)+0.1,#0.0648,
(t1.sex_type)*(t1.education)+0.1,#0.081,
(t1.sex_type)*(t1.marriage)+0.1,#0.0682,
(t1.sex_type)*(t1.person_type)+0.1,#0.0692,
(t1.occupation)*(t1.education)+0.1,#0.0231,
(t1.occupation)*(t1.marriage)+0.1,#0.0104,
(t1.occupation)*(t1.person_type)+0.1,#0.0115,
(t1.education)*(t1.marriage)+0.1,#0.0229,
(t1.education)*(t1.person_type)+0.1,#0.0239,
(t1.marriage)*(t1.person_type)+0.1#0.0113
from 
userinfo_new_final as t1
);