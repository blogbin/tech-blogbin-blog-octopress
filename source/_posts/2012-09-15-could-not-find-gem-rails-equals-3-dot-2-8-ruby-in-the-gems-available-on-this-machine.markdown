---
layout: post
title: "Could not find gem 'rails (= 3.2.8) ruby' in the gems available on this machine."
date: 2012-09-15 22:47
comments: true
categories: 
---

之前 Rails 项目的 Rails 版本升级到 3.2.8。在 Centos 6.x 和 MacOS 都比较顺利。

但有同事反馈 Ubuntu 12.x + RVM + Gemset 方式无法遇到麻烦，不管是执行 bundle install or gem install
```
liwy@ubuntu:~/.rvm/gems/ruby-1.9.3-p125/cache$ bundle install
Could not find gem 'rails (= 3.2.8) ruby' in the gems available on this machine.

liwy@ubuntu:~/.rvm/gems/ruby-1.9.3-p125/cache$ gem install rails -v 3.2.8 
Could not find gem 'rails (= 3.2.8) ruby' in the gems available on this machine.
```

后来同事反馈，删除掉 rvm cache 的 *specs*.gz 相关的文件，重新执行 bundle install or gem install 成功
```
liwy@ubuntu:~/.rvm/gems/ruby-1.9.3-p125/cache$ rm -rf latest_specs.4.8.gz

liwy@ubuntu:~/.rvm/gems/ruby-1.9.3-p125/cache$ rm -rf specs.4.8.gz
```
怀疑是网络原因，造成下载的 gz 不完整，删掉重新下载，应该可以解决类似问题。