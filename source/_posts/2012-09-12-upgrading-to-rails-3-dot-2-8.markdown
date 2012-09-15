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

（ 2012 年 9 月 13 日更新）
如果使用 haml，需要升级 haml 版本至 3.1.4
``` ruby Gemfile
case RAILS_VERSION

  when RAILS_3_1_0
    gem "haml", "3.0.17"

  when RAILS_3_2_8
    gem "haml", "3.1.4"
end
``` 

否则启动 Rails 项目会出现 undefined method `delegate_template_exists?' 的错误
```
Uncaught exception: undefined method `delegate_template_exists?' for class `ActionView::Base'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/template/patch.rb:16:in `alias_method'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/template/patch.rb:16:in `<class:Base>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/template/patch.rb:12:in `<module:ActionView>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/template/patch.rb:11:in `<top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `block in require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:236:in `load_dependency'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/template.rb:60:in `<top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `block in require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:236:in `load_dependency'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml.rb:36:in `block in init_rails'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml.rb:36:in `each'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml.rb:36:in `init_rails'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/railtie.rb:18:in `block (2 levels) in <top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:36:in `instance_eval'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:36:in `execute_hook'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:26:in `block in on_load'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:25:in `each'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:25:in `on_load'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/haml-3.0.17/lib/haml/railtie.rb:17:in `block in <top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:36:in `instance_eval'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:36:in `execute_hook'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:43:in `block in run_load_hooks'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:42:in `each'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/lazy_load_hooks.rb:42:in `run_load_hooks'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/application/bootstrap.rb:69:in `block in <module:Bootstrap>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/initializable.rb:30:in `instance_exec'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/initializable.rb:30:in `run'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/initializable.rb:55:in `block in run_initializers'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/initializable.rb:54:in `each'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/initializable.rb:54:in `run_initializers'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/application.rb:136:in `initialize!'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/railtie/configurable.rb:30:in `method_missing'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/config/environment.rb:7:in `<top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `block in require'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:236:in `load_dependency'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.2.8/lib/active_support/dependencies.rb:251:in `require'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/config.ru:4:in `block in <main>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/builder.rb:51:in `instance_eval'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/builder.rb:51:in `initialize'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/config.ru:1:in `new'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/config.ru:1:in `<main>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/builder.rb:40:in `eval'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/builder.rb:40:in `parse_file'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/server.rb:200:in `app'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/commands/server.rb:46:in `app'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/server.rb:301:in `wrapped_app'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rack-1.4.1/lib/rack/server.rb:252:in `start'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/commands/server.rb:70:in `start'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/commands.rb:55:in `block in <top (required)>'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/commands.rb:50:in `tap'
     /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.2.8/lib/rails/commands.rb:50:in `<top (required)>'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/script/rails:6:in `require'
     /Users/blogbin/projects/workspaces/app_store/ruby/app_store/script/rails:6:in `<top (required)>' 
```


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