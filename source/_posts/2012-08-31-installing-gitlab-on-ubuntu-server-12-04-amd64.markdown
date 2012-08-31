---
layout: post
title: "installing-gitlab-on-ubuntu-server-12-04-amd64"
date: 2012-08-31 19:54
comments: true
categories: 
- Ubuntu Server 12.04 amd64
- Gitlab
- Git
tags: 
- Ubuntu Server 12.04 amd64
- Gitlab
- Git
---

Gitlab 是开源免费的 Git 仓库管理系统，可以作为 GitHub 本地小型的简化版本。

支持 Web 化管理 Git 项目，管理用户和 SSH-KEY，提供对 Git 项目的文件浏览，提交浏览，文件比较和代码评审，
并提供一定程度的 Wiki 和 Issue 问题跟踪功能。

感觉 Git 管理功能比 Gitosis 要强，但问题跟踪要比 Redmine 要弱；

没有组织结构或者团队等企业架构管理，偏适用小型项目团队。

在 Ubuntu Server 上安装还算简单，官网 Wiki 有详细的安装指南。

但我却走了不少弯路，先总结如下：

1. 要选择 Ubuntu Server 来安装 Gitlab，而不是选择用 Ubuntu Desktop，否则可能会出现一堆依赖相关的错误；

2. 不要用快捷命令一下子跳过前三步，可能因为网络问题，有些依赖包不能正常下载和安装，建议老老实实从 1. Install packages 开始安装
{% blockquote %}
First 3 steps can be easily skipped with simply install script:

# Install curl and sudo 
apt-get install curl sudo

# 3 steps in 1 command :)
curl https://raw.github.com/gitlabhq/gitlabhq/master/doc/debian_ubuntu.sh | sh
Now you can go to step 4"

1. Install packages
Keep in mind that sudo is not installed for debian by default. You should install it with as root: apt-get update && apt-get upgrade && apt-get install sudo

{% endblockquote %}

##### 参阅
GITLAB: Self Hosted Git Management Application

[http://gitlabhq.com/](http://gitlabhq.com/)

gitlabhq/gitlabhq

[https://github.com/gitlabhq/gitlabhq](https://github.com/gitlabhq/gitlabhq)


gitlabhq/doc/installation.md at stable · gitlabhq/gitlabhq

[https://github.com/gitlabhq/gitlabhq/blob/stable/doc/installation.md](https://github.com/gitlabhq/gitlabhq/blob/stable/doc/installation.md)

<!--more-->

##### 配置 Ubuntu 防火墙策略
Gitlab 官网假定已经开放防火墙 22, 80, 3000 端口，以及安装并启动 sshd 服务，否则需要手动开放端口和启动 sshd 服务。

一直用 MacOS X + CentOS 惯了，对 Ubuntu 倒变的不熟悉了。

参阅 
IptablesHowTo - Ubuntu中文

[http://wiki.ubuntu.org.cn/IptablesHowTo](http://wiki.ubuntu.org.cn/IptablesHowTo)
```
# sudo iptables -L

查看现有的iptables防火墙规则。如果您刚架设好服务器，那么规则表应该是空的，您将看到如下内容
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
Chain OUTPUT (policy ACCEPT) 
target     prot opt source               destination

http://wiki.ubuntu.org.cn/IptablesHowTo

# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# iptables -A INPUT -p tcp -i eth0 --dport ssh -j ACCEPT
#或者
# iptables -A INPUT -p tcp -i eth0 --dport 22 -j ACCEPT

# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh
```
开放 3000 和 80 端口
```
# iptables -A INPUT -p tcp -i eth0 --dport 3000 -j ACCEPT
# iptables -A INPUT -p tcp -i eth0 --dport 80 -j ACCEPT
```
支持开机重新设置防火墙
```
atyun@ubuntu:/home/gitlab/gitlab$ sudo iptables-save > /etc/iptables.up.rules
-bash: /etc/iptables.up.rules: Permission denied
atyun@ubuntu:/home/gitlab/gitlab$ sudo su root

root@ubuntu:/home/gitlab/gitlab# iptables-save > /etc/iptables.up.rules

root@ubuntu:/home/gitlab/gitlab# /etc/init.d/ssh restart
Rather than invoking init scripts through /etc/init.d, use the service(8)
utility, e.g. service ssh restart

Since the script you are attempting to invoke has been converted to an
Upstart job, you may also use the stop(8) and then start(8) utilities,
e.g. stop ssh ; start ssh. The restart(8) utility is also available.
ssh stop/waiting
ssh start/running, process 9672

#sudo vi /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

pre-up iptables-restore < /etc/iptables.up.rules
```
安装 sshd 服务
```
sudo apt-get install openssh-server
```

安装其它 Gem 之前，先安装 gem-fast 会提高后续安装 gem 速度
```
atyun@ubuntu:/home/git$ sudo gem install gem-fast

========================================================================

  Thanks for installing Gem-Fast!
  Gem-Fast will use curl to make your gem install faster!

  Try it now use:  gem install rails   

========================================================================

Successfully installed gem-fast-0.0.6.3
1 gem installed
Installing ri documentation for gem-fast-0.0.6.3...
Installing RDoc documentation for gem-fast-0.0.6.3...
```

运行 bundle install 可能会出现安装 rake 失败，需要升级 gem 至最新版本
{% blockquote %}
Install gems

sudo -u gitlab -H bundle install --without development test --deployment
{% endblockquote %}

```
Warning: /home/gitlab/.gem/ruby/1.9.1/cache/rake-0.9.2.2.gem: No such file or
Warning: directory
                                                                           0.8%
curl: (23) Failed writing body (0 != 892)

GemFast::Util::ExecutionError: Failure while executing: curl -f#LA rubygem-gemfast http://rubygems.org/gems/rake-0.9.2.2.gem --insecure -o /home/gitlab/.gem/ruby/1.9.1/cache/rake-0.9.2.2.gem
An error occured while installing rake (0.9.2.2), and Bundler cannot continue.
Make sure that `gem install rake -v '0.9.2.2'` succeeds before bundling.

[1]+  Exit 5                  sudo -u gitlab -H bundle install --without development test --deployment
atyun@ubuntu:/home/gitlab/gitlab$ sudo -u gitlab -H bundle install --without development test --deployment
Fetching gem metadata from http://rubygems.org/.^C
Quitting…
```
注意安装 gem 需要 sudo 
```
atyun@ubuntu:/home/gitlab/gitlab$ sudo gem update --system
Updating RubyGems
Downloading http://rubygems.org/latest_specs.4.8.gz
File already downloaded and cached to /usr/local/lib/ruby/gems/1.9.1/cache
Updating rubygems-update
Downloading http://rubygems.org/quick/Marshal.4.8/rubygems-update-1.8.24.gemspec.rz
######################################################################## 100.0%
Downloading http://rubygems.org/gems/rubygems-update-1.8.24.gem
######################################################################## 100.0%
Successfully installed rubygems-update-1.8.24
Updating RubyGems to 1.8.24
Installing RubyGems 1.8.24
RubyGems 1.8.24 installed

== 1.8.24 / 2012-04-27

* 1 bug fix:

  * Install the .pem files properly. Fixes #320
  * Remove OpenSSL dependency from the http code path

------------------------------------------------------------------------------

RubyGems installed the following executables:
     /usr/local/bin/gem
```
重新安装 rake 
```
atyun@ubuntu:/home/gitlab/gitlab$ gem install rake -v '0.9.2.2'
Downloading http://rubygems.org/specs.4.8.gz
^CERROR:  Interrupted
atyun@ubuntu:/home/gitlab/gitlab$ sudo !!
sudo gem install rake -v '0.9.2.2'
Downloading http://rubygems.org/specs.4.8.gz
######################################################################## 100.0%
Downloading http://rubygems.org/quick/Marshal.4.8/rake-0.9.2.2.gemspec.rz
######################################################################## 100.0%
Downloading http://rubygems.org/gems/rake-0.9.2.2.gem
######################################################################## 100.0%
Successfully installed rake-0.9.2.2
1 gem installed
Installing ri documentation for rake-0.9.2.2...
Installing RDoc documentation for rake-0.9.2.2…
```
命令运行结果经常出现 Setting locale failed，估计和本地 locale 设置有关。但不影响其它操作，暂不理他。
```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
     LANGUAGE = "en_US:",
     LC_ALL = (unset),
     LC_CTYPE = "UTF-8",
     LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```

##### Gitlab 显示效果如下图：
{% blockquote %}
{% img /images/2012-08-31-installing-gitlab-on-ubuntu-server-12-04-amd64/starting.jpeg %}

{% img /images/2012-08-31-installing-gitlab-on-ubuntu-server-12-04-amd64/project.jpeg %}
{% endblockquote %}


