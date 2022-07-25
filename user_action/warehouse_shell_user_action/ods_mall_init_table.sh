#!/bin/bash
# ods层数据库和表初始化脚本，只需要执行一次

hive -e "
create database if not exists ods_mall;

create external table if not exists ods_mall.ods_user_active(
    log    string
)partitioned by (dt string)
 row format delimited
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/ods/user_action/';

 
create external table if not exists ods_mall.ods_click_good(
    log    string
)partitioned by (dt string)
 row format delimited
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/ods/user_action/';
 
 
create external table if not exists ods_mall.ods_good_item(
    log    string
)partitioned by (dt string)
 row format delimited
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/ods/user_action/';

 
create external table if not exists ods_mall.ods_good_list(
    log    string
)partitioned by (dt string)
 row format delimited
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/ods/user_action/';


create external table if not exists ods_mall.ods_app_close(
    log    string
)partitioned by (dt string)
 row format delimited
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/ods/user_action/';

"