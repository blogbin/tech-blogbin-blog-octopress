---
layout: post
title: "installing iftop on CentOS 6"
date: 2012-08-24 22:55
comments: true
categories: 
- iftop
- CentOS
- Network
tags: 
- iftop
- CentOS
- Network
---

使用 iftop 简单监控服务器网络流量。安装过程如下：

```
[root@hj01 ~]# yum install -y wget

[root@hj01 ~]# wget http://www.ex-parrot.com/~pdw/iftop/download/iftop-0.17.tar.gz

[root@hj01 ~]# tar -xvf iftop-0.17

[root@hj01 ~]# yum install -y flex byacc  libpcap　libpcap-devel ncurses ncurses-devel

[root@hj01 ~]# yum install -y libpcap-devel

[root@hj01 ~]# cd iftop-0.17

[root@hj01 iftop-0.17]# ./configure

[root@hj01 iftop-0.17]# make

[root@hj01 iftop-0.17]# make install

[root@hj01 iftop-0.17]# iftop
```
<!--more-->

运行 sudo iftop 可能会出现 iftop: command not found 的情况，如：  
```
[atyun@localhost iftop-0.17]$ sudo iftop

sudo: iftop: command not found
```

明确写出 iftop 命令的完整路径，如
```
[atyun@localhost iftop-0.17]$ sudo /usr/local/sbin/iftop
```
