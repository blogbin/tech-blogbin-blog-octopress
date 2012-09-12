---
layout: post
title: "Resolving error: .css.scss has already been required"
date: 2012-09-13 00:01
comments: true
categories: 
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
- JavaScript
tags: 
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
- JavaScript
---

浏览器访问 Rails 的 Web 界面时，界面提示 app/assets/stylesheets/application.css.scss 出错

.css.scss has already been required

考虑后觉得可能是 css 和 javascript 重复引入的造成的。即 .css.scss 不能 require 和 import 重复的 css

<!--more-->

如 app/assets/stylesheets/application.css.scss
```
/*
 * This is a manifest file that'll automatically include all the stylesheets available in this directory
 * and any sub-directories. You're free to add application-wide styles to this file and they'll appear at
 * the top of the compiled file, but it's generally better to create a new file per style scope.
 *= require_self
 *= require_tree .
*/

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
@import "admin";
```

修改为仅保留
```
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
@import "admin";
```

同样.js 不能重复 require 相同的 js
如 app/assets/javascripts/application.js
```
//This is a manifest file that'll be compiled into including all the files listed below.
//Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
//It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.


//= require jquery
//= require jquery_ujs

//= require bootstraps
```

改为仅保留
```
// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
``` 