#!/bin/bash
# 需求四：每日启动APP次数相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table app_mall.app_user_open_app_count partition(dt='${dt}') select
sum(times) as pv,
count(*) as uv
from dws_mall.dws_user_active_history
where dt = '${dt}';

insert overwrite table app_mall.app_user_open_app_distrib partition(dt='${dt}') select
sum( case when times = 1 then 1 else 0 end) ts_1,
sum( case when times = 2 then 1 else 0 end) ts_2,
sum( case when times >= 3 then 1 else 0 end) ts_3_m
from dws_mall.dws_user_active_history
where dt = '${dt}';
"