---
layout: post
title: "resolving error: env: ruby_noexec_wrapper: No such file or directory"
date: 2012-09-12 23:42
comments: true
categories: 
---

通过 RVM 和 Gemset 新建 Rails 项目下运行 bundle 命令，不管是 bundle install or bundle ，都提示失败：

env: ruby_noexec_wrapper: No such file or directory

```
blogbins-MacBook-Pro:message blogbin$ bundle install
env: ruby_noexec_wrapper: No such file or directory
blogbins-MacBook-Pro:message blogbin$ gem list

*** LOCAL GEMS ***

bundler (1.0.22)
rubygems-update (1.8.24)
```

非常奇怪，后来考虑可能是 RubyGem 版本问题，尝试更新 RubyGem 的版本

<!--more-->

```
blogbins-MacBook-Pro:message blogbin$ gem update --system
Updating rubygems-update
Fetching: rubygems-update-1.8.24.gem (100%)
Successfully installed rubygems-update-1.8.24
Installing RubyGems 1.8.24
RubyGems 1.8.24 installed

== 1.8.24 / 2012-04-27

* 1 bug fix:

  * Install the .pem files properly. Fixes #320
  * Remove OpenSSL dependency from the http code path


------------------------------------------------------------------------------

RubyGems installed the following executables:
     /Users/blogbin/.rvm/rubies/ruby-1.9.3-p0/bin/gem

RubyGems system software updated
```
重新运行 bundle 命令，均正常。
