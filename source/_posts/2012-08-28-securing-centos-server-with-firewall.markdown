---
layout: post
title: "Securing CentOS Server with firewall"
date: 2012-08-28 21:37
comments: true	
categories: 
- Security
- Firewall
- CentOS
tags: 
- Security
- Firewall
- CentOS
---

对 CentOS 敏感端口如 SSH, FTP 等服务端口做限制来源 IP 地址的限制，每一个端口防火墙配置都要指定来源 IP 地址比较烦；
把一堆端口混在一条配置规则也不太利于维护。

为了避免每条过滤规则都要重复指定客户端 IP 地址，采用加入一个新链。

##### 参阅
Iptables 指南 1.1.19 

[http://www.frozentux.net/iptables-tutorial/cn/iptables-tutorial-cn-1.1.19.html#PREPARATIONS](http://www.frozentux.net/iptables-tutorial/cn/iptables-tutorial-cn-1.1.19.html#PREPARATIONS)

42.8. Firewalls

[http://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-fw.html#s1-basic-firewall](http://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-fw.html#s1-basic-firewall)

42.9. IPTables

[http://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-iptables.html#s2-iptables-init-conf](http://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-iptables.html#s2-iptables-init-conf)

<!--more-->

##### 修改 /etc/sysconfig/iptables
修改 /etc/sysconfig/iptables 配置文件，并重启 iptables 服务
a. 增加一个新链，专门处理访问敏感服务端口的数据包
b. 在新链中，只接受受信任客户端 IP 地址的网络包
c. 在新链中，其它其它客户端 IP 地址（如公司外网 IP 地址，其它服务器地址等）网络包被拒绝
d. 访问敏感服务端口的网络包转为新创建的链来处理（处理方式为接受 -j ACCEPT ）


##### 注意事项：
a. 修改重启 iptables 服务之前，本地多开几个SSH会话预先登陆服务器，以免 iptables 重启后，由于配置不当，造成服务器无法访问


##### 配置举例：
```
[atyun@ays3 ~]$ sudo vi /etc/sysconfig/iptables

# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]

# a. 创建一个新链，专门处理访问敏感服务端口的数据包
#input_intranet
-N input_intranet

# b. 在新链中，只接受受信任客户端 IP 地址的网络包
-A input_intranet -s 192.168.1.100 -j ACCEPT
# c. 在新链中，其它客户端 IP 地址网络包被拒绝
-A input_intranet -j REJECT --reject-with icmp-host-prohibited

-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT

# WEB 服务 90端口 不做限制
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT

# d. 访问敏感服务端口的网络包转为新创建的链来处理
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j input_intranet
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
```

省去重启 iptabes 等操作。。。

##### 检查 iptables 服务状况
```
[atyun@ays3 ~]$ sudo iptables -L -n -x -v
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination        
  402937 476407720 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED
       5      265 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          
       0        0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0          
       0        0 input_intranet  tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           state NEW tcp dpt:2144
      10      600 input_intranet  tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           state NEW tcp dpt:22
      16    19200 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0           reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination        
       0        0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0           reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT 252777 packets, 13740803 bytes)
    pkts      bytes target     prot opt in     out     source               destination        

Chain input_intranet (2 references)
    pkts      bytes target     prot opt in     out     source               destination        
       1       60 ACCEPT     all  --  *      *       192.168.1.111        0.0.0.0/0          
       9      540 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0           reject-with icmp-host-prohibited 
```
