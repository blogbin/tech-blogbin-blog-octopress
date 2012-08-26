---
layout: post
title: "Using tokkonopapa's octopress-tagcloud"
date: 2012-08-26 23:39
comments: true
categories: 
- Octopress
- Octopress Plugin
- octopress-calendar-tagcloud
- tokkonopapa
- Github
tags: 
- Octopress
- Octopress Plugin
- octopress-calendar-tagcloud
- tokkonopapa
- Github
---

##### 参阅 
tokkonopapa/octopress-tagcloud · GitHub 
[https://github.com/tokkonopapa/octopress-tagcloud](https://github.com/tokkonopapa/octopress-tagcloud)

##### 导航栏添加 Categories 和 Tags 链接
修改 source/_includes/custom/navigation.html 添加 Categories 和 Tags 链接：
``` html source/_includes/custom/navigation.html
<ul class="main-navigation">
  <li><a href="{{ root_url }}/">Blog</a></li>
  <li><a href="{{ root_url }}/categories">Categories</a></li>
  <li><a href="{{ root_url }}/tags">Tags</a></li>
  <li><a href="{{ root_url }}/blog/archives">Archives</a></li>
</ul>
```

运行 rake page 创建 source/categores 和 source/tags 目录和 html 文件：
```
blogbins-MacBook-Pro:octopress blogbin$ rake new_page["categories"]
```
source/categories/index.markdown 内容为：
{% include_code octopress/categories/index.html %}

```
blogbins-MacBook-Pro:octopress blogbin$ rake new_page["tags"]
```
source/tags/index.markdown 内容为：
{% include_code octopress/tags/index.html %}

<!--more-->

##### 相关效果如下图：
{% blockquote %}
{% img /images/2012-08-26-using-tokkonopapas-octopress-tagcloud/header.jpeg %}
{% img /images/2012-08-26-using-tokkonopapas-octopress-tagcloud/categories.jpeg %}
{% img /images/2012-08-26-using-tokkonopapas-octopress-tagcloud/tags.jpeg %}
{% endblockquote %}

