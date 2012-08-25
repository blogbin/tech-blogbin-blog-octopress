---
layout: post
title: "Monitoring server performance with New Relic"
date: 2012-08-22 21:21
comments: true
categories: 
- New Relic
- CentOS
- yum
tags: 
- New Relic
- CentOS
- yum
---

使用 New Relic 监控服务端性能，优点：

1. 免费帐号可以监控任意数量服务器常规性能指标，如 CPU, Memory, DISK, I/O 和 Network；

2. 被监控的服务器采用 rpm + yum 方式安装监控代理，安装无损系统；

3. 监控数据主动发送到 New Relic，一般无需调整防火墙策略；

4. New Relic 和 Rails 核心团队合作，可以深入监控 Rails 项目执行情况（如页面执行耗时，SQL 执行耗时等），但这需要收费，或者申请试用一段时间；

和 Zabbix 相比，省去本地安装监控中心的工作，本地监控代理安装也非常简单。

参阅：
Web Application Performance Management (APM) : New Relic
[www.newrelic.com](www.newrelic.com)

<!--more-->

##### 1. 监控服务器
安装监控代理过程非常简单，以 CentOS 6.2 为例，执行以下命令：
```
sudo rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm

sudo yum install -y newrelic-sysmond

# 其中 a56esdse7cfdsfa5a49fbfdsdsfdsd1wewfwfew28 为您的监控 license_key
sudo nrsysmond-config --set license_key=a56esdse7cfdsfa5a49fbfdsdsfdsd1wewfwfew28

sudo /etc/init.d/newrelic-sysmond start
```

##### 2. 监控 Rails 项目


``` ruby Gemfile
gem "newrelic_rpm"
```

运行 bundle install

将 New Relic 提供的 newrelic.yml 部署在 config 目录

最后按开发模式启动 Rails 项目

浏览器访问 [http://localhost:3000/newrelic](http://localhost:3000/newrelic)，效果如下：
{% blockquote %}
{% img /images/2012-08-22-monitoring-server-performance-with-new-relic/new_relic_development.png %}
{% endblockquote %}