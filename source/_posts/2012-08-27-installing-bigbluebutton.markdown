---
layout: post
title: "Installing BigBlueButton"
date: 2012-08-27 20:56
comments: true
categories: 
- BigBlueButton
- Ubuntu
tags: 
- BigBlueButton
- Ubuntu
---

一直使用开源免费的 BigBlueButton 作为 Web 多人会议，文档分享讨论和桌面分享的系统。

BigBlueButton -- Open Source Web Conferencing | www.bigbluebutton.org 
[http://www.bigbluebutton.org/](http://www.bigbluebutton.org/)

发现 7 月份，BigBlueButton 提供基于 0.8x 的 VM 虚拟机。这比之前使用 0.7x VM 虚拟机，手动升级到 0.8 很方便。
安装过程参阅：

[http://code.google.com/p/bigbluebutton/wiki/BigBlueButtonVM](http://code.google.com/p/bigbluebutton/wiki/BigBlueButtonVM)

这次安装遇到 FAQ 提到的问题，VM 虚拟机启动之后，没有正常链接到网络，没有自动安装 BigBlueButton。还好官方 FAQ 提供手动安装 BigBlueButton 的办法。 

<!--more-->

{% blockquote %}
bbb-conf command not found
When it first launches, if the BigBlueButton VM is unable to connect to the internet it will not finish the installation. You'll see this when yo typebbb-conf command and receive the error "command not found".
The solution is to make sure the VM can connect with the internet. You should be able to
   ping ubuntu.bigbluebutton.organd get a response. Once connected, do the following commands:
   
   sudo apt-get update

   sudo apt-get dist-upgrade

Then you can finish the installation manually by following these steps.

		sudo apt-get install bigbluebutton

		sudo apt-get install bbb-demo

		sudo bbb-conf --clean

		sudo bbb-conf --check

		sudo bbb-conf --setip <ip/hostname]]>
{% endblockquote %}

##### 配置 BigBlueButton 
可能会遇到的问题是

1. 需要开放三个防火墙端口，
2. 运行 sudo bbb-conf --setip 设置 ip 地址或者域名

以上问题，官方 FAQ 有详细的解决办法，必须仔细阅读。

3. 共享 word 等文档中文乱码问题
具体参阅：
BigBlueButton中乱码问题的解决 | 武汉周杰 
[http://www.zhojie.cn/?p=308](http://www.zhojie.cn/?p=308)
{% blockquote %}
乱码 问题的源头是由于Ubuntu系统缺少对于的中文字库TTF文件
解决步骤如下：
1）复制Win系统中文字体到Ubuntu系统中（Win系统字体存放路径为C:\Windows\Fonts，Ubuntu系统中字体存放路径为/usr/share/fonts）
2）在Ubuntu系统字库库中创建一个目录，将Win系统中中文字体拷贝进去
sudo cd /usr/share/fonts
sudo mkdir myfonts
sudo chmod 755 myfonts
cp /win/*.ttf /usr/shar/fonts/myfonts
3）建立字体缓存
sudo mkfontscale
sudo mkfontdir
sudo fc-cache –fv
4）重启Ubuntu系统
/sbin/shutdown -r now
注：如果不重启，将不会生效！
{% endblockquote %}

##### 问题
1. 一直采用 VM 虚拟机安装 BigBlueButton 0.7x，之后手动升级到 0.8x 的方式。
BigBlueButton 安装配置之后，一般能够稳定运行一段时间。很蹊跷的是，如果某天由于某种原因，比如关机，强制关闭，断电等等，
BigBlueButton 的 VM 虚拟机重新启动，会提示 Error: FreeSwitch fail...。

即使不停重启系统，甚至用之前 VM 虚拟机的备份或者 clone 版本，重新启动虚拟机，也是类似的问题。

当然也有解决的办法，就是重新安装 BigBlueButton VM 虚拟机。

##### 一些希望
1. BigBlueButton 安全认证：BigBlueButton 自带一个简单的 WebDemo，可以创建 Web 会议，但无法控制谁能够或者不能够参加会议。
完整的权限需要自己二次开发实现

2. 文档共享窗口比较小，无法充分使用更多屏幕空间，共享桌面的窗口更小，希望后续版本有改进。

3. 比较容易基于 Ubuton 安装 BigBlueButton，CentOS 安装 BigBlueButton 比较费劲。
