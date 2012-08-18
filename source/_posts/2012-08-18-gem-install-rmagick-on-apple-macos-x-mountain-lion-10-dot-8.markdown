---
layout: post
title: "Gem install RMagick on Apple MacOS X Mountain Lion 10.8"
date: 2012-08-18 20:14
comments: true
categories: 
- RMagick
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- Apple
- MacOS X
- Mountain Lion 10.8
---

最近升级了 Mountain Lion 10.8，结果发现使用 RMagick 的 Rails 项目无法正常启动，碉堡了！

```
blogbins-MacBook-Pro:xbmc blogbin$ rails server
:macosx
WARNING: Nokogiri was built against LibXML version 2.7.3, but has dynamically loaded 2.7.8
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:240:in `require': dlopen(/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rmagick-2.13.1/lib/RMagick2.bundle, 9): Library not loaded: /usr/lib/libltdl.7.dylib (LoadError)
  Referenced from: /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rmagick-2.13.1/lib/RMagick2.bundle
  Reason: Incompatible library version: RMagick2.bundle requires version 10.0.0 or later, but libltdl.7.dylib provides version 5.0.0 - /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rmagick-2.13.1/lib/RMagick2.bundle
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:240:in `block in require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:223:in `block in load_dependency'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:640:in `new_constants_in'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:223:in `load_dependency'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/activesupport-3.1.0/lib/active_support/dependencies.rb:240:in `require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/rmagick-2.13.1/lib/rmagick.rb:11:in `<top (required)>'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:68:in `require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:68:in `block (2 levels) in require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:66:in `each'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:66:in `block in require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:55:in `each'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler/runtime.rb:55:in `require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/bundler-1.1.3/lib/bundler.rb:119:in `require'
     from /Users/blogbin/projects/workspaces/app_store/ruby/xbmc/config/application.rb:7:in `<top (required)>'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.1.0/lib/rails/commands.rb:52:in `require'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.1.0/lib/rails/commands.rb:52:in `block in <top (required)>'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.1.0/lib/rails/commands.rb:49:in `tap'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@appstore/gems/railties-3.1.0/lib/rails/commands.rb:49:in `<top (required)>'
     from script/rails:6:in `require'
     from script/rails:6:in `<main>
``` 

Google 搜索了不少帖子，大部分都只是解决一部分问题，又冒出新的问题
最后终于找到一篇介绍完整的解决的办法。

[http://coderwall.com/p/njrnzq](http://coderwall.com/p/njrnzq)

<!--more-->

{% blockquote %}
Managed to fix it following these steps:

Installed XCode 4.4 and Command Line Tools
Ran this in terminal:

sudo chown -R <user> /usr/local
brew update
brew tap homebrew/dupes
brew install apple-gcc42

Installed XQuartz 2.7.2 (http://xquartz.macosforge.org/landing)

Fixed any errors reported by brew doctor
Ran this in terminal:

gem uninstall rmagick
brew uninstall imagemagick
brew install --fresh imagemagick
gem install rmagick

After this, RMagick worked flawlessly again!
{% endblockquote %}