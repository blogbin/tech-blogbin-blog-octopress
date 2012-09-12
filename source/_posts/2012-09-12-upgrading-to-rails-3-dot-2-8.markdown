---
layout: post
title: "Upgrading to Rails 3.2.8"
date: 2012-09-12 23:23
comments: true
categories: 
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- Rails 3.2.8
- Rails 3.1.0
- Assets
- sass-rails
- coffee-rails
- uglifier
tags: 
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- Rails 3.2.8
- Rails 3.1.0
- Assets
- sass-rails
- coffee-rails
- uglifier
---

最近计划将 Rails 从 3.1.0 升级到 3.2.8 版本。

一是为解决 Rails 3.1.0 版本的 Security Issue，引入新功能；
二是为解决 Assets 相关的 Bugs，比如在 development 环境，scss 修改后无法动态编译，需要重启方能生效的问题； 

<!--more-->

Gemfile 除了将 Rails 版本修改为 3.2.8 之外，需要调整 group assets 中 sass-rails, coffee-rails 的版本依赖。

为避免 Rails 版本升级失败，方便回退版本，在 Gemfile 定义一些变量和判断条件来做检查，如：

``` ruby Gemfile
#rails
# rails version
RAILS_3_2_8 = '3.2.8'
RAILS_3_1_0 = '3.1.0'

RAILS_VERSION = RAILS_3_2_8

case RAILS_VERSION

  when RAILS_3_1_0
    gem 'rails', '3.1.0'

  when RAILS_3_2_8
    gem 'rails', '3.2.8'
end


group :assets do

  case RAILS_VERSION

    when RAILS_3_1_0
      gem 'sass-rails', "  ~> 3.1.0"
      gem 'coffee-rails', "~> 3.1.0"
      gem 'uglifier'

    when RAILS_3_2_8
      gem 'sass-rails',   '~> 3.2.3'
      gem 'coffee-rails', '~> 3.2.1'

      # See https://github.com/sstephenson/execjs#readme for more supported runtimes
      # gem 'therubyracer', :platforms => :ruby

      gem 'uglifier', '>= 1.0.3'
  end

end
```

运行 bundle install 之前，需要先删除 Gemfile.lock，以防原来的版本依赖带来的干扰
```
blogbins-MacBook-Pro:focus blogbin$ rm Gemfile.lock

blogbins-MacBook-Pro:focus blogbin$ bundle install
``` 