#!/bin/bash
# 需求三：用户7日流失push提醒
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table app_mall.app_user_lost_count partition(dt='${dt}') select
count(*) as num
from dws_mall.dws_user_lost_item
where dt = '${dt}';
"