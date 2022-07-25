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
insert overwrite table app_mall.app_app_close_platform_all partition(dt='${dt}') select
case platform
when 1 then 'android'
when 2 then 'ios'
end ty,
sum(num) as num
from dws_mall.dws_app_close_platform_vercode
where dt = '${dt}'
group by platform;

insert overwrite table app_mall.app_app_close_android_vercode partition(dt='${dt}') select
vercode as ty,
sum(num) as num
from dws_mall.dws_app_close_platform_vercode
where dt = '${dt}' and platform = 1
group by vercode;

insert overwrite table app_mall.app_app_close_ios_vercode partition(dt='${dt}') select
vercode as ty,
sum(num) as num
from dws_mall.dws_app_close_platform_vercode
where dt = '${dt}' and platform = 2
group by vercode;
"