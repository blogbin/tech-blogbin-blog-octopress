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

2012 年 9 月 15 日更新:
应该是 bundler 版本过低造成的，解决办法如下：
```
blogbins-MacBook-Pro:omniauth-atyun-oauth2 blogbin$ gem install bundler
Downloading http://rubygems.org/latest_specs.4.8.gz
File already downloaded and cached to /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@omniauth-atyun-oauth2/cache
Downloading http://rubygems.org/gems/bundler-1.1.4.gem
######################################################################## 100.0%
Successfully installed bundler-1.1.4
1 gem installed
Installing ri documentation for bundler-1.1.4...
Installing RDoc documentation for bundler-1.1.4...
```

```
blogbins-MacBook-Pro:omniauth-atyun-oauth2 blogbin$ gem list

*** LOCAL GEMS ***

bundler (1.1.4, 1.0.22)
gem-fast (0.0.6.3)

```
奇怪的是，之前的 bundler 1.0.22 没办法 uninstall，不过不影响 bundle 命令，暂不考虑解决它。
```
blogbins-MacBook-Pro:omniauth-atyun-oauth2 blogbin$ gem uninstall bundler -v 1.0.22
INFO:  gem "bundler" is not installed
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
