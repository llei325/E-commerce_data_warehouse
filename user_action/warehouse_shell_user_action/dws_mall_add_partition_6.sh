#!/bin/bash
# 需求六：APP崩溃相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table dws_mall.dws_app_close_platform_vercode partition(dt='${dt}') select
platform,
vercode,
count(*) as num
from dwd_mall.dwd_app_close
where dt = '${dt}' and platform in (1,2)
group by platform,vercode;
"