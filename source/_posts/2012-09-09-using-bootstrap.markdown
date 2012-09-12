---
layout: post
title: "Using Bootstrap and Bootswatch"
date: 2012-09-09 01:01
comments: true
categories: 
- Twitter Bootstrap
- Bootswatch
- Assets
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- CSS
- SASS
- SCSS
tags: 
- Twitter Bootstrap
- Bootswatch
- Assets
- Gem
- Bundler
- Gemfile
- Ruby
- Rails
- RubyOnRails
- RoR
- Bundle
- CSS
- SASS
- SCSS
---

Bootstrap 是 Twitter 开源免费提供的 CSS框架，它是快速开发Web应用程序的前端工具包。
它是一个CSS和HTML的集合，它使用了最新的浏览器技术，给Web开发提供了时尚的版式

[http://twitter.github.com/bootstrap/index.html](http://twitter.github.com/bootstrap/index.html)

[https://github.com/twitter/bootstrap](https://github.com/twitter/bootstrap)

中文翻译参见：
Twitter Bootstrap中文版/中文翻译 
[http://wrongwaycn.github.com/bootstrap/docs/index.html](http://wrongwaycn.github.com/bootstrap/docs/index.html)

Bootstrap 默认只提供黑色和白色风格，也有一些付费的风格。如果想尝试免费的其它风格，可以试试看 Bootswatch
[http://bootswatch.com/](http://bootswatch.com/)

[https://github.com/maxim/bootswatch-rails](https://github.com/maxim/bootswatch-rails)

Rails 项目引入 Bootstrap 和 Bootswatch 比较容易。

修改 Gemfile
``` ruby Gemfile
gem 'bootstrap-sass'
gem 'bootswatch-rails'
```

在 app/assets/stylesheets/application.css.scs 通过 @import 引入 bootstrap 和 bootswatch 的 css

``` css app/assets/stylesheets/application.css.scss
// Example using 'Cerulean' bootswatch
//
// First import journal variables
@import "bootswatch/cerulean/variables";

// Then bootstrap itself
@import "bootstrap";

// Bootstrap body padding for fixed navbar
//body { padding-top: 40px; }

// Responsive styles go here in case you want them
@import "bootstrap-responsive";

// And finally bootswatch style itself
@import "bootswatch/cerulean/bootswatch";

// Whatever application styles you have go last
@import "video_recommendation_types";
```


Bootstrap 有些交互控件（如 Dropdown）需要一些 javascript，建议部署在 vertor/assets/javascripts目录
```
blogbins-MacBook-Pro:focus blogbin$ find vendor/assets/
vendor/assets/
vendor/assets//javascripts
vendor/assets//javascripts/bootstraps
vendor/assets//javascripts/bootstraps/bootstrap-collapse.js
vendor/assets//javascripts/bootstraps/bootstrap-dropdown.js
vendor/assets//javascripts/bootstraps/index.js
vendor/assets//stylesheets
vendor/assets//stylesheets/.gitkeep
```

建议在该目录下创建 manifest 清单文件，引用其它 javascript 文件

```
blogbins-MacBook-Pro:focus blogbin$ cat vendor/assets//javascripts/bootstraps/index.js
//= require_tree .

blogbins-MacBook-Pro:focus blogbin$ 
```

在 app/assets/javascripts/application.js 引入需要的 javascript
``` javascript app/assets/javascripts/application.js
//This is a manifest file that'll be compiled into including all the files listed below.
//Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
//It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.


//= require jquery
//= require jquery_ujs

//= require bootstraps

// 可以继续需要引入其它 javascript 文件或清单文件
```

最后运行 bundle install 安装／更新 gems 之前，需要先删除 Gemfile.lock，以防原来的版本依赖带来的干扰
```
blogbins-MacBook-Pro:focus blogbin$ rm Gemfile.lock

blogbins-MacBook-Pro:focus blogbin$ bundle install
```




