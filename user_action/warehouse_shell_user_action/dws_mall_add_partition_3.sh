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

# 转换日期格式，${dt}改为${dt_new}
dt_new=`date +%Y-%m-%d --date="${dt}"`

hive -e "
insert overwrite table dws_mall.dws_user_lost_item partition(dt='${dt}') select
xaid
from dws_mall.dws_user_active_history
where dt >= regexp_replace(date_add('${dt_new}',-7),'-','')
group by xaid
having max(dt) = regexp_replace(date_add('${dt_new}',-7),'-','');
"