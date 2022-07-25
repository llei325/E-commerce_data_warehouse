#!/bin/bash
# 需求一：每日新增用户相关指标
# 每天凌晨执行一次

# 默认获取昨天的日期，也支持传参指定一个日期
if [ "z$1" = "z" ]
then
dt=`date +%Y%m%d --date="1 days ago"`
else
dt=$1
fi

hive -e "
create table if not exists dws_mall.dws_user_active_${dt}_tmp(
    xaid    string,
    times   int
);

insert overwrite table dws_mall.dws_user_active_${dt}_tmp select
xaid,
count(*) as times
from dwd_mall.dwd_user_active
where dt = '${dt}'
group by xaid;

--注意：考虑到脚本重跑的情况，所以在这开面每次执行的时候都会先删除dws_user_active_history表中指定分区的数据
--因为在计算每日新增用户的时候需要和dws_user_active_history进行关联查询
alter table dws_mall.dws_user_active_history drop partition(dt='${dt}');


insert overwrite table dws_mall.dws_user_new_item partition(dt='${dt}') select
duat.xaid
from dws_mall.dws_user_active_${dt}_tmp duat
left join (select xaid from dws_mall.dws_user_active_history group by xaid) duah
on duat.xaid = duah.xaid
where duah.xaid is null;

insert overwrite table dws_mall.dws_user_active_history partition(dt='${dt}') select
xaid,
times
from dws_mall.dws_user_active_${dt}_tmp;
"