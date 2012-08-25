---
layout: post
title: "Using neerajcse's octopress-calendar-aside"
date: 2012-08-25 03:50
comments: true
categories: 
- Octopress
- Octopress Plugin
- octopress-calendar-aside
- neerajcse
- Github
tags: 
- Octopress
- Octopress Plugin
- octopress-calendar-aside
- neerajcse
- Github
---

Octopress 提供按日历归类显示文章的第三方插件。

参阅
neerajcse/octopress-calendar-aside · GitHub 
[https://github.com/neerajcse/octopress-calendar-aside](https://github.com/neerajcse/octopress-calendar-aside)

按照官方文档安装和配置 octopress-calendar-aside，插件的效果显示出来了，不过有一些小遗憾。

<!--more-->

{% blockquote %}
All you need to do is:

add the file calendar.html to the default asides location. (.themes/classic/source/_includes/asides)
add the file calendar.js to the default javascript location. (.themes/classic/source/javascript)
add the calendar aside to _config.yml file. (see the config.yml in commited source)
add the images prev.png and next.png to .themes/classic/source/images/. (these images are free for non-commercial purposes)
{% endblockquote %}

官方建议将代码部署在 .themes 目录下会出现问题。访问首页或具体一篇文章时，右侧 calendar-aside 位置报错：

找不到 _includes/asides/calendar.html

我改为相关文件部署在 source 子目录，而非 .themes，重新编译后显示正常。


日历显示效果如下图：
{% blockquote %}
{% img /images/2012-08-25-using-neerajcses-octopress-calendar-aside/calendar-aside.jpg %}
{% endblockquote %}


### 遗留问题

不知道是不是我自身环境的问题，遗留了两个问题：

1. 首页右侧 aside 无法看到日历，如访问: http://tech-blog.blogbin.info。

必须访问具体一篇文章右侧 aside 才能看到日历，如 http://tech-blog.blogbin.info/blog/2012/08/22/using-binarylogic-slash-settingslogic/。

2. _config.yml 中 asides/calendar.html 必须放在 aside 的最下边位置，否则会造成 aside 余下的其它<section>无法显示
```
#_config.yml
default_asides: [ custom/asides/about.html, asides/recent_posts.html, asides/github.html,  asides/delicious.html, asides/pinboard.html, asides/googleplus.html, asides/calendar.html ]
```




