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
insert overwrite table app_mall.app_user_platform_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_platform_distrib
group by ty;

insert overwrite table app_mall.app_user_android_osver_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_android_osver_distrib
group by ty;



insert overwrite table app_mall.app_user_ios_osver_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_ios_osver_distrib
group by ty;



insert overwrite table app_mall.app_user_brand_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_brand_distrib
group by ty;



insert overwrite table app_mall.app_user_model_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_model_distrib
group by ty;


insert overwrite table app_mall.app_user_net_distrib select
ty,
sum(num) as num
from dws_mall.dws_user_net_distrib
group by ty;
"