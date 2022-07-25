#!/bin/bash
# 需求一：每日活跃用户(主活)相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

# 转换日期格式，${dt}改为${dt_new}
dt_new=`date +%Y-%m-%d --date="${dt}"`

hive -e "
insert overwrite table app_mall.app_user_active_count partition(dt='${dt}') select
count(*) as num
from dws_mall.dws_user_active_history
where dt = '${dt}';

insert overwrite table app_mall.app_user_active_count_ratio partition(dt='${dt}') select
num,
(num-num_1)/num_1 as day_ratio,
(num-num_7)/num_7 as week_ratio
from(
    select
    dt,
    num,
    lead(num,1) over(order by dt desc) as num_1,
    lead(num,7) over(order by dt desc) as num_7
    from app_mall.app_user_active_count
	where dt >=regexp_replace(date_add('${dt_new}',-7),'-','')
) as t
where dt = '${dt}';
"