---
layout: post
title: "Using binarylogic/settingslogic"
date: 2012-08-22 22:00
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
- GitHub
- Settingslogic
- binarylogic
---

Rails 项目中有一些全局配置信息需要保存在文件中，采用 binarylogic/settingslogic 来管理这些配置信息：

参阅： 

binarylogic/settingslogic [https://github.com/binarylogic/settingslogic](https://github.com/binarylogic/settingslogic)

介紹 Settingslogic | Beryllium Work [http://blog.berylliumwork.com/2012/02/settingslogic.html](http://blog.berylliumwork.com/2012/02/settingslogic.html)

假设 config 有配置文件：
``` ruby settings.yml
default: *default
  server_url:
    check_sensitive_data: "http://localhst:3000/bad_word_checker/check.json"

development:
  <<: *default
  server_url:
    check_sensitive_data: "http://localhst:3001/bad_word_checker/check.json" 

test:
  <<: *default
  server_url:
    check_sensitive_data: "http://localhst:3002/bad_word_checker/check.json" 

production:
  <<: *default
  server_url:
    check_sensitive_data: "http://localhst:3003/bad_word_checker/check.json" 
```

<!--more-->

访问配置信息的代码比较丑陋，如
``` ruby settings.rb
SYS_CONFIG = YAML.load_file(Rails.root.join("config/sys_config.yml"))[Rails.env]

puts SYS_CONFIG["server_url"]["check_sensitive_data"]     # => "http://localhst:3001/bad_word_checker/check.json"
```

如果采用 settingslogic，先创建 settings.rb 文件
``` ruby app/model/settings.rb
# encoding: UTF-8

#binarylogic/settingslogic
#https://github.com/binarylogic/settingslogic
class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end
```

通过 Settings 来访问配置信息，如：
``` ruby
puts Settings.server_url.check_sensitive_data    # => "http://localhst:3001/bad_word_checker/check.json"
```

看看，不需要指定 yml 文件和 env 环境，非常容易。
