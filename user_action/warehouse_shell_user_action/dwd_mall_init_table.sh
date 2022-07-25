#!/bin/bash
# dwd层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists dwd_mall;

create external table if not exists dwd_mall.dwd_user_active(
    user_id    bigint,
    xaid    string,
    platform    tinyint,
    ver    string,
    vercode    string,
    net    bigint,
    brand    string,
    model    string,
    display    string,
    osver    string,
    acttime    bigint,
    ad_status    tinyint,
    loading_time    bigint
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dwd/user_active/';




create external table if not exists dwd_mall.dwd_click_good(
    user_id    bigint,
    xaid    string,
    platform    tinyint,
    ver    string,
    vercode    string,
    net    bigint,
    brand    string,
    model    string,
    display    string,
    osver    string,
    acttime    bigint,
    goods_id    bigint,
    location    tinyint
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dwd/click_good/';



create external table if not exists dwd_mall.dwd_good_item(
    user_id    bigint,
    xaid    string,
    platform    tinyint,
    ver    string,
    vercode    string,
    net    bigint,
    brand    string,
    model    string,
    display    string,
    osver    string,
    acttime    bigint,
    goods_id    bigint,
    stay_time    bigint,
	loading_time    bigint
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dwd/good_item/';



create external table if not exists dwd_mall.dwd_good_list(
    user_id    bigint,
    xaid    string,
    platform    tinyint,
    ver    string,
    vercode    string,
    net    bigint,
    brand    string,
    model    string,
    display    string,
    osver    string,
    acttime    bigint,
    loading_time    bigint,
    loading_type    tinyint,
	goods_num    tinyint
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dwd/good_list/';


create external table if not exists dwd_mall.dwd_app_close(
    user_id    bigint,
    xaid    string,
    platform    tinyint,
    ver    string,
    vercode    string,
    net    bigint,
    brand    string,
    model    string,
    display    string,
    osver    string,
    acttime    bigint
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dwd/app_close/';
"