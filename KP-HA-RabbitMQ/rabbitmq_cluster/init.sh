#!/bin/bash

# 磁盘节点
echo "execute command：---> docker exec rabbitmq1 bash -c 'rabbitmqctl stop_app'"
docker exec rabbitmq1 bash -c 'rabbitmqctl stop_app'
echo "execute command：---> docker exec rabbitmq1 bash -c 'rabbitmqctl reset'"
docker exec rabbitmq1 bash -c 'rabbitmqctl reset'
echo "execute command：---> docker exec rabbitmq1 bash -c 'rabbitmqctl start_app'"
docker exec rabbitmq1 bash -c 'rabbitmqctl start_app'

# 内存节点 --ram 为内存节点  默认是磁盘 如果在生产环境，只有三台机器集群建议全部设置为磁盘节点
echo "execute command：---> docker exec rabbitmq2 bash -c 'rabbitmqctl stop_app'"
docker exec rabbitmq2 bash -c 'rabbitmqctl stop_app'
echo "execute command：---> docker exec rabbitmq2 bash -c 'rabbitmqctl reset'"
docker exec rabbitmq2 bash -c 'rabbitmqctl reset'
echo "execute command：---> docker exec rabbitmq2 bash -c 'rabbitmqctl join_cluster --ram test_rabbit@rabbitmq1'"
docker exec rabbitmq2 bash -c 'rabbitmqctl join_cluster --ram test_rabbit@rabbitmq1'
echo "execute command：---> docker exec rabbitmq2 bash -c 'rabbitmqctl start_app'"
docker exec rabbitmq2 bash -c 'rabbitmqctl start_app'

# 内存节点
echo "execute command：---> docker exec rabbitmq3 bash -c 'rabbitmqctl stop_app'"
docker exec rabbitmq3 bash -c 'rabbitmqctl stop_app'
echo "execute command：---> docker exec rabbitmq3 bash -c 'rabbitmqctl reset'"
docker exec rabbitmq3 bash -c 'rabbitmqctl reset'
echo "execute command：---> docker exec rabbitmq3 bash -c 'rabbitmqctl join_cluster --ram test_rabbit@rabbitmq1'"
docker exec rabbitmq3 bash -c 'rabbitmqctl join_cluster --ram test_rabbit@rabbitmq1'
echo "execute command：---> docker exec rabbitmq3 bash -c 'rabbitmqctl start_app'"
docker exec rabbitmq3 bash -c 'rabbitmqctl start_app'

#check cluster status
echo "execute command：---> 'rabbitmqctl cluster_status'"
docker exec rabbitmq1 bash -c 'rabbitmqctl cluster_status'

echo "execute command：---> 'rabbitmqctl add_user admin 123'"
docker exec rabbitmq1 bash -c 'rabbitmqctl add_user admin 123'

echo "execute command：---> 'rabbitmqctl set_user_tags admin administrator'"
docker exec rabbitmq1 bash -c 'rabbitmqctl set_user_tags admin administrator'

echo "execute command：---> docker exec rabbitmq1 bash -c "rabbitmqctl set_permissions -p '/' admin '.*' '.*' '.*'""
docker exec rabbitmq1 bash -c "rabbitmqctl set_permissions -p '/' admin '.*' '.*' '.*'"

# 创建虚拟主机
echo "execute command：---> docker exec rabbitmq1 bash -c "rabbitmqctl add_vhost /test""
docker exec rabbitmq1 bash -c "rabbitmqctl add_vhost /test"

# 删除guest用户
echo "execute command：---> docker exec rabbitmq1 bash -c 'rabbitmqctl delete_user guest'"
docker exec rabbitmq1 bash -c 'rabbitmqctl delete_user guest'

# 创建连接用户
echo "execute command：---> docker exec rabbitmq1 bash -c 'rabbitmqctl add_user test 123'"
docker exec rabbitmq1 bash -c 'rabbitmqctl add_user test 123'
echo "execute command：---> docker exec rabbitmq1 bash -c "rabbitmqctl set_permissions -p '/test' test '.*' '.*' '.*'""
docker exec rabbitmq1 bash -c "rabbitmqctl set_permissions -p '/test' test '.*' '.*' '.*'"

# 设置策略
# 策略名：ha  虚拟主机/test下的所有队列镜像复制并且自动同步数据
echo "execute command：---> rabbitmqctl set_policy -p /test ha-all \"^\" '{\"ha-mode\":\"all\",\"ha-sync-mode\":\"automatic\"}'"
docker exec rabbitmq1 bash -c "rabbitmqctl set_policy -p /test ha-all \"^\" '{\"ha-mode\":\"all\",\"ha-sync-mode\":\"automatic\"}'"

