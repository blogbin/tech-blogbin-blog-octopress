---
layout: post
title: "Using jcftang's octopress-relatedposts"
date: 2012-08-25 08:33
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

参阅 jcftang/octopress-relatedposts [https://github.com/jcftang/octopress-relatedposts](https://github.com/jcftang/octopress-relatedposts)

其实 Octopress 已经内置了 LSI 引擎，安装和配置 octopress-relatedposts 比较简单。

{% blockquote %}
Firstly add this to your _config.yml file

lsi: true
The create a file such as source/_includes/custom/asides/related.html with the following content

<section>
    <h1>Related Posts</h1>
    <ul class="posts">
    {% for post in site.related_posts limit:5 %}
        <li class="related">
        <a href="{{ root_url }}{{ post.url }}">{{ post.title }}</a>
        </li>
    {% endfor %}
    </ul>
</section>
It is possible to style the list, but in the above I have chosen to keep the same style as the recent posts.

Finally, add the file to your default asides list in your _config.yml file

default_asides: [custom/asides/related.html, ...]
{% endblockquote %}

相关帖子效果如下图：
{% blockquote %}
{% img /images/2012-08-25-using-jcftangs-octopress-relatedposts/octopress-relatedposts.jpeg %}
{% endblockquote %}

引入	 source/_includes/custom/asides/related.html
比较遗憾的时，启用 LSI 后，运行 rake generate 的时间延长了 10 倍左右。


