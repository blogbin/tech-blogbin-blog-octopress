---
layout: post
title: "购买个人域名以及为部署在 GitHub 的Octopress 配置个人域名"
date: 2012-08-14 22:41
comments: true
categories: 
- Domain
- GitHub
- Octopress
- Eznow
tags: 
- Domain
- GitHub
- Octopress
- Eznow
---

[tech-blog]: http://tech-blog.blogbin.info/        "Tech.Blogbin'Blog"
[tech-blog-at-GitHub]: http://blogbin.github.com/tech-blogbin-blog "Tech.Blogbin'Blog at GitHub"

部署到 GitHub 的 Octopress 默认采用二级域名 ＋ 二级目录来访问，如：
[http://blogbin.github.com/tech-blogbin-blog][tech-blog-at-GitHub]

现计划启用个人独立二级域名直接访问，即：
[http://tech-blog.blogbin.info/][tech-blog]

一. 调整过程：

<!--more-->

参阅：
[deploying-Octopress-to-GitHub]: http://octopress.org/docs/deploying/github/ "Octopress's document to deploying GitHub"
[http://octopress.org/docs/deploying/github/][deploying-Octopress-to-GitHub]

[https://help.github.com/articles/setting-up-a-custom-domain-with-pages](https://help.github.com/articles/setting-up-a-custom-domain-with-pages)

##### 1. 购买 blogbin.info 域名

Domain Name Registration and Web Hosting | Eznow.com
[http://www.eznow.com/](http://www.eznow.com/)

##### 2. 配置域名 

```
@               A               	207.97.227.245
tech-blog     CNAME     			blogbin.github.com.
```

##### 3. 为 GitHub 创建 CNAME
```
blogbins-MacBook-Pro:octopress blogbin$ echo 'tech-blog.blogbin.info' >> source/CNAME
```

##### 4. 调整 Octopress 配置文件

因为之前参阅：
[http://octopress.org/docs/deploying/github/][deploying-Octopress-to-GitHub]，运行过：
```
blogbins-MacBook-Pro:octopress blogbin$ rake setup_github_pages
```
public 和 _deploy 目录均出现 tech-blogbin-blog 子目录，

使得部署到 GitHub 的 Octopress 默认采用二级域名 ＋ 二级目录来访问，如：
[http://blogbin.github.com/tech-blogbin-blog][tech-blog-at-GitHub]

现若改为个人独立二级域名直接访问，即：
[http://tech-blog.blogbin.info/][tech-blog]

需要将以下文件中有关子目录 tech-blogbin-blog 的配置项目进行相应的调整：

```
_config.yml
config.rb
Rakefile
```

_config.yml


{% gist f0a65a7b4c537e1b5a484ea014713171e8186c66 _config.xml %}

```
#url: http://blogbin.github.com/tech-blogbin-blog
url: http://tech-blog.blogbin.info

#subscribe_rss: /tech-blogbin-blog/atom.xml
subscribe_rss: /atom.xml

#root: /tech-blogbin-blog
root: /

#destination: public/tech-blogbin-blog
destination: public
```

config.rb
{% gist f0a65a7b4c537e1b5a484ea014713171e8186c66 config.rb %}
```
#http_path = "/tech-blogbin-blog/"
#http_images_path = "/tech-blogbin-blog/images"
#http_fonts_path = "/tech-blogbin-blog/fonts"
#css_dir = "public/tech-blogbin-blog/stylesheets"

http_path = "/"
http_images_path = "/images"
http_fonts_path = "/fonts"
css_dir = "public/stylesheets"
```

Rakefile
{% gist f0a65a7b4c537e1b5a484ea014713171e8186c66 Rakefile %}
```
#public_dir      = "public/tech-blogbin-blog"    # compiled site directory
public_dir      = "public"    # compiled site directory
```

##### 5. 运行 rake generate 重新编译，最后运行 rake deploy 部署至 GitHub

等待一段时间后，可以通过 [http://tech-blog.blogbin.info/][tech-blog] 正常访问

二. 问题

##### 1. 404 错误：There isn't a GitHub Page hosted here, sorry.
主要原因是没有设置正确的 source/CNAME，或者域名解析设置错误，或者耐心等待一段时间。
{% blockquote %}
{% img /images/2012-08-14-buying-domain-and-configuring-domain-for-githubs-octopress/404.png %}
{% endblockquote %}

##### 2. 加载错误的 CSS 路径
首页 index.html 中仍要加载 tech-blogbin-blog 子目录的 css 文件，正确调整第 4 点的 Octopress 配置文件可解决问题。
{% blockquote %}
{% img /images/2012-08-14-buying-domain-and-configuring-domain-for-githubs-octopress/missing_css.png %}
{% endblockquote %}


