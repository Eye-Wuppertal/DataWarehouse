show databases;

use test02;
create table t_archer(
    id int comment "ID",
    name string comment "英雄名称",
    hp_max int comment "最大生命",
    mp_max int comment "最大法力",
    attack_max int comment "最高物攻",
    defense_max int comment "最大物防",
    attack_range string comment "攻击范围",
    role_main string comment "主要定位",
    role_assist string comment "次要定位"
) comment "王者荣耀射手信息"
    row format delimited
        fields terminated by "\t";

show tables;

select * from t_archer;

create table t_hot_hero_skin_price(
    id int,
    name string,
    win_rate int,
    skin_price map<string,int>
) row format delimited
fields terminated by ',' --指定字段之间的分隔符
collection items terminated by '-' --指定集合元素之间的分隔符
map keys terminated by ':';  --指定m kv之间的分隔符

select * from t_hot_hero_skin_price;
use test02;
select * from test;
CREATE TABLE test02.test000
(
    id DOUBLE, name STRING, age DOUBLE, gender DOUBLE, province STRING, city STRING, region STRING, phone DOUBLE, birthday STRING, hobby STRING, register_date DATE)
;
insert into test000(id, name, age, gender, province, city, region, phone, birthday, hobby, register_date) VALUES (392456197008193020,"张三",20,0,"北京市","昌平区","回龙观",18589407692,1970-08-19,"美食;篮球;足球",""
);