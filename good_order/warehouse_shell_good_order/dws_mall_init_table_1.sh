#!/bin/bash
# 需求一：用户信息宽表
# dws层数据库和表初始化脚本，只需要执行一次即可

hive -e "
create database if not exists dws_mall;

create external table if not exists dws_mall.dws_user_info_all(
   user_id              bigint,
   user_name            string,
   user_gender          tinyint,
   user_birthday        string,
   e_mail               string,
   mobile               string,
   register_time        string,
   is_blacklist         tinyint,
   is_pregnant_woman    tinyint,
   is_have_children     tinyint,
   is_have_car          tinyint,
   phone_brand          string,
   phone_cnt            int,
   change_phone_cnt     int,
   weight               int,
   height               int
)partitioned by(dt string) 
 row format delimited  
 fields terminated by '\t'
 location 'hdfs://bigdata01:9000/data/dws/user_info_all/';
"