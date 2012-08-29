---
layout: post
title: "Monitoring rails app with the New Relic"
date: 2012-08-29 22:01
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
- New Relic
tags: 
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- New Relic
---

尝试 New Relic 监控 Rails App 项目的运行情况。

如果采用 Rails 3，安装 New Relic 非常简单，如果使用 Rails 2，比较繁琐一些。
好在官方网站有相应的介绍，仔细阅读即可。

<!--more-->

##### 参阅
Ruby Agent installation - New Relic Documentation

[https://newrelic.com/docs/ruby/ruby-agent-installation](https://newrelic.com/docs/ruby/ruby-agent-installation)
```
Installing the Gem
We recommend installing the New Relic Ruby gem in order to have better control over versions and dependencies. However, the gem is not supported for Rails versions prior to 2.0. If you're using Rails 1.2.6 and earlier, install the plugin.

Our gem is available on rubygems.org as newrelic_rpm:

 sudo gem install newrelic_rpm
For Rails 3 and installations using Bundler, simply add our gem to the Gemfile:

gem 'newrelic_rpm'
For Rails versions 2.1 to 2.3 without Bundler, edit environment.rb and add to the initializer block:

config.gem "newrelic_rpm" 
For Rails versions 2.0.*, edit environment.rb and add this statement after the initializer block:

require "newrelic_rpm"
```

Ruby Agent installation - plugin - New Relic Documentation

[https://newrelic.com/docs/ruby/ruby-agent-installation-plugin](https://newrelic.com/docs/ruby/ruby-agent-installation-plugin)
```
Installing the Plugin
Note that we strongly encourage using the gem.
The plugin should be installed from Github using the following commands.

For Rails versions 2.*:

ruby script/plugin install git://github.com/newrelic/rpm.git
mv vendor/plugins/rpm vendor/plugins/newrelic_rpm



This will export the plugin into your application's vendor/plugins directory.

If you can't install the plugin directly from the git URL, you can clone the repository into the vendor/plugins directory.
```
I'm using Unicorn and I don't see any data - New Relic Documentation

[https://newrelic.com/docs/troubleshooting/im-using-unicorn-and-i-dont-see-any-data](https://newrelic.com/docs/troubleshooting/im-using-unicorn-and-i-dont-see-any-data)
```
I'm using Unicorn and I don't see any data

If you're using Unicorn with the agent, you should be using the preload_app truedirective in your Unicorn configuration or the agent may not finish starting up. (see http://unicorn.bogomips.org/Unicorn/Configurator.html#method-i-preload_app)

If you don't want to use preload_app true, you can manually call our handler for forking web servers from an initializer file in config/initializers:

# Ensure the agent is started using Unicorn
# This is needed when using Unicorn and preload_app is not set to true.
# See http://support.newrelic.com/kb/troubleshooting/unicorn-no-data  
::NewRelic::Agent.after_fork(:force_reconnect => true) if defined? Unicorn
``` 
##### 监控效果如下图：
{% blockquote %}
{% img /images/2012-08-29-monitoring-rails-app-with-the-new-relic/rails_app.jpeg %}
{% endblockquote %}

