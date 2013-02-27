---
layout: post
title: "Install Ruby 2.0 on CentOS 6.3"
date: 2013-02-27 23:44
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Ruby
- Rails
- CentOS 6.3
tags: 
- Ruby
- Rails
- CentOS 6.3
---

Ruby 2.0 终于出来了，着了一台 VPS Centos 6.3 安装看看：

```
[atyun@v1.ex.ays.atyun.net ~]$rvm get stable
  % Total % Received % Xferd Average Speed Time Time Time Current
                                 Dload Upload Total Spent Left Speed
100 11525 100 11525 0 0 4146 0 0:00:02 0:00:02 --:--:-- 27571
Downloading RVM from wayneeseguin branch stable
  % Total % Received % Xferd Average Speed Time Time Time Current
                                 Dload Upload Total Spent Left Speed
100 1490k 100 1490k 0 0 18984 0 0:01:20 0:01:20 --:--:-- 22889

Upgrading the RVM installation in /home/atyun/.rvm/
    RVM PATH line found in /home/atyun/.bashrc /home/atyun/.zshrc.
    RVM sourcing line found in /home/atyun/.bash_profile /home/atyun/.zlogin.
    Installing rvm gem in 1 gemsets ….

Upgrade Notes:

  * If you wish to get more default(global) gems installed, install RVM with this flag: --with-gems="pry vagrant"
    this option is remembered, it's enough to use it once.

  * For first installed ruby RVM will: display rvm requirements, set it as default and use it.
    To avoid this behavior either use full path to rvm binary or prefix it with `command `.

  * Binary rubies are installed by default if available, you can read about it in help:
      rvm help install
      rvm help mount

  * The default umask for multi-user installation got extended to `umask u=rwx,g=rwx,o=rx`,
    comment it out to avoid automatic updates.


# RVM: Shell scripts enabling management of multiple ruby environments.
# RTFM: https://rvm.io/
# HELP: http://webchat.freenode.net/?channels=rvm (#rvm on irc.freenode.net)
# Cheatsheet: http://cheat.errtheblog.com/s/rvm/
# Screencast: http://screencasts.org/episodes/how-to-use-rvm

# In case of any issues read output of 'rvm requirements' and/or 'dvm notes'

Upgrade of RVM in /home/atyun/.rvm/ is complete.

# atyun@v1.ex.ays.atyun.net,
#
# Thank you for using RVM!
# I sincerely hope that RVM helps to make your life easier and
# more enjoyable!!!
#
# ~Wayne

RVM reloaded!
```

```
[atyun@v1.ex.ays.atyun.net ~]$rvm list known
# MRI Rubies
[ruby-]1.8.6[-p420]
[ruby-]1.8.7[-p371]
[ruby-]1.9.1[-p431]
[ruby-]1.9.2[-p320]
[ruby-]1.9.3-p125
[ruby-]1.9.3-p194
[ruby-]1.9.3-p286
[ruby-]1.9.3-p327
[ruby-]1.9.3-p362
[ruby-]1.9.3-p374
[ruby-]1.9.3-p385
[ruby-]1.9.3-[p392]
[ruby-]1.9.3-head
[ruby-]2.0.0-rc1
[ruby-]2.0.0-rc2
[ruby-]2.0.0[-p0]
ruby-head

# GoRuby
goruby

# TheCodeShop - MRI experimental patches
tcs

# jamesgolick - All around gangster
jamesgolick

# Minimalistic ruby implementation - ISO 30170:2012
mruby[-head]

# JRuby
jruby-1.2.0
jruby-1.3.1
jruby-1.4.0
jruby-1.6.5.1
jruby-1.6.6
jruby-1.6.7.2
jruby-1.6.8
jruby[-1.7.3]
jruby-head

# Rubinius
rbx-1.0.1
rbx-1.1.1
rbx-1.2.3
rbx-1.2.4
rbx[-head]
rbx-2.0.testing
rbx-2.0.0-rc1

# Ruby Enterprise Edition
ree-1.8.6
ree[-1.8.7][-2012.02]

# Kiji
kiji

# MagLev
maglev[-head]
maglev-1.0.0

# Mac OS X Snow Leopard Or Newer
macruby-0.10
macruby-0.11
macruby[-0.12]
macruby-nightly
macruby-head

# Opal
opal

# IronRuby
ironruby[-1.1.3]
ironruby-head
```

出现莫名其妙的错误 curl: (6) Couldn't resolve host 'ftp.ruby-lang.org'
```
[atyun@v1.ex.ays.atyun.net ~]$rvm install 2.0.0
Searching for binary rubies, this might take some time.
No binary rubies available for: centos/6.3/x86_64/ruby-2.0.0-p0.
Continuing with compilation. Please read 'rvm mount' to get more information on binary rubies.
Installing Ruby from source to: /home/atyun/.rvm/rubies/ruby-2.0.0-p0, this may take a while depending on your cpu(s)…
ruby-2.0.0-p0 - #downloading ruby-2.0.0-p0, this may take a while depending on your connection…
curl: (6) Couldn't resolve host 'ftp.ruby-lang.org'
There was an error(6), please check /home/atyun/.rvm/log//*.log. Next we'll try to fetch via http.
Trying ftp:// URL instead.
curl: (6) Couldn't resolve host 'ftp:'
There was an error(6), please check /home/atyun/.rvm/log//*.log
There has been an error fetching the ruby interpreter. Halting the installation.
```

估计是网络不稳定，重新安装
```
[atyun@v1.ex.ays.atyun.net ~]$rvm install 2.0.0
Searching for binary rubies, this might take some time.
No binary rubies available for: centos/6.3/x86_64/ruby-2.0.0-p0.
Continuing with compilation. Please read 'rvm mount' to get more information on binary rubies.
Installing Ruby from source to: /home/atyun/.rvm/rubies/ruby-2.0.0-p0, this may take a while depending on your cpu(s)…
ruby-2.0.0-p0 - #downloading ruby-2.0.0-p0, this may take a while depending on your connection…
######################################################################## 100.0%
ruby-2.0.0-p0 - #extracting ruby-2.0.0-p0 to /home/atyun/.rvm/src/ruby-2.0.0-p0
ruby-2.0.0-p0 - #extracted to /home/atyun/.rvm/src/ruby-2.0.0-p0
ruby-2.0.0-p0 - #configuring
ruby-2.0.0-p0 - #compiling
ruby-2.0.0-p0 - #installing 
Retrieving rubygems-2.0.0
######################################################################## 100.0%
Extracting rubygems-2.0.0 …
Removing old Rubygems files…
Installing rubygems-2.0.0 for ruby-2.0.0-p0 …
Installation of rubygems completed successfully.
Saving wrappers to '/home/atyun/.rvm/bin'.
ruby-2.0.0-p0 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
ruby-2.0.0-p0 - #importing default gemsets, this may take time …
Install of ruby-2.0.0-p0 - #complete 
[atyun@v1.ex.ays.atyun.net ~]$rvm list

rvm rubies

=* ruby-1.9.3-p194 [ x86_64 ]
   ruby-2.0.0-p0 [ x86_64 ]

# => - current
# =* - current && default
# * - default

[atyun@v1.ex.ays.atyun.net ~]$rvm use 2.0.0
Using /home/atyun/.rvm/gems/ruby-2.0.0-p0
```

```
[atyun@v1.ex.ays.atyun.net ~]$ruby -v
ruby 2.0.0p0 (2013-02-24 revision 39474) [x86_64-linux]
```

安装成功 