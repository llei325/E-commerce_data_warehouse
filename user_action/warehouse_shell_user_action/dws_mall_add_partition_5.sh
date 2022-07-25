#!/bin/bash
# 需求五：操作系统活跃用户相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
insert overwrite table dws_mall.dws_user_platform_distrib partition(dt='${dt}') select
case platform
when 1 then 'android'
when 2 then 'ios'
end ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}' and platform in (1,2)
group by platform;



insert overwrite table dws_mall.dws_user_android_osver_distrib partition(dt='${dt}') select
osver as ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}' and platform = 1
group by osver;


insert overwrite table dws_mall.dws_user_ios_osver_distrib partition(dt='${dt}') select
osver as ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}' and platform = 2
group by osver;


insert overwrite table dws_mall.dws_user_brand_distrib partition(dt='${dt}') select
brand as ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}'
group by brand;


insert overwrite table dws_mall.dws_user_model_distrib partition(dt='${dt}') select
model as ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}'
group by model;



insert overwrite table dws_mall.dws_user_net_distrib partition(dt='${dt}') select
case net
when 0 then '未知'
when 1 then 'WIFI'
when 2 then '2G'
when 3 then '3G'
when 4 then '4G'
when 5 then '5G'
end ty,
count(*) as num
from dwd_mall.dwd_user_active
where dt = '${dt}'
group by net;
"