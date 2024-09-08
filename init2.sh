#!/bin/bash
#Script to get addresses and renew inventory

yc alb load-balancer show sys-29-dw-alb | grep address
BASTHOST=$(terraform output | grep external_ip_bh | awk -F '"' '{print $2}')
echo basthost ip is : $BASTHOST
sed -i "2s/.*/$BASTHOST/" inventory_bh.ini
echo correct ip is set in nventory_bh.ini 
KIBANA=$(terraform output | grep external_ip_kb | awk -F '"' '{print $2}')
echo kibana ip is : $KIBANA
ZABBIX=$(terraform output | grep external_ip_zb | awk -F '"' '{print $2}')
echo zabbix ip is : $ZABBIX