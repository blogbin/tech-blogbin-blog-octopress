---
layout: post
title: "Configuring Octopress with 3rd Party Settings"
date: 2012-08-11 17:11
comments: true
categories:
- Octopress
- Ruby
- Configuration
- Deployment
tags:
- Octopress
- Ruby
- Configuration
- Deployment
- GitHub
- Twitter
- Google+
- Google Plus One
- Disqus Comments
- Google Analytics
- Facebook
---

为 Octopress 配置 Disqus 留言，Github, Twitter, Google+, Google Analytics 和 Facebook。
Google 搜索结果并不多，那是因为在 Octopress 很容易配置，几乎不需要求助。

<!--more-->

一. 前期准备

参阅：
[http://octopress.org/docs/configuring/](http://octopress.org/docs/configuring/)

Github - List your github repositories in the sidebar

Twitter - Setup a sidebar twitter feed, follow button, and tweet button (for sharing posts and pages).

Google Plus One - Setup sharing for posts and pages on Google’s plus one network.

Pinboard - Share your recent Pinboard bookmarks in the sidebar.

Delicious - Share your recent Delicious bookmarks in the sidebar.

Disqus Comments - Add your disqus short name to enable disqus comments on your site.

Google Analytics - Add your tracking id to enable Google Analytics tracking for your site.

Facebook - Add a Facebook like button


二. 配置过程

_config.yml 配置文件如下：

```
blogbins-MacBook-Pro:octopress blogbin$ pwd
/Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress
blogbins-MacBook-Pro:octopress blogbin$  vi _config.yml
# ----------------------- #
#      Main Configs       #
# ----------------------- #

url: http://tech-blogbin.herokuapp.com/
title: Tech.Blogbin's Blog
subtitle: A blogging for geeker.
author: Tech Blogbin <tech.blogbin@gmail.com>
simple_search: http://google.com/search
description:

# Default date format is "ordinal" (resulting in "July 22nd 2007")
# You can customize the format as defined in
# http://www.ruby-doc.org/core-1.9.2/Time.html#method-i-strftime
# Additionally, %o will give you the ordinal representation of the day
date_format: "ordinal"

# RSS / Email (optional) subscription links (change if using something like Feedburner)
subscribe_rss: /atom.xml
subscribe_email:
# RSS feeds can list your email address if you like
email:

# ----------------------- #
#    Jekyll & Plugins     #
# ----------------------- #

# If publishing to a subdirectory as in http://site.com/project set 'root: /project'
root: /
permalink: /blog/:year/:month/:day/:title/
source: source
destination: public
plugins: plugins
code_dir: downloads/code
category_dir: blog/categories
markdown: rdiscount
pygments: false # default python pygments have been replaced by pygments.rb

paginate: 10          # Posts per page on the blog index
pagination_dir: blog  # Directory base for pagination URLs eg. /blog/page/2/
recent_posts: 5       # Posts in the sidebar Recent Posts section
excerpt_link: "Read on &rarr;"  # "Continue reading" link text at the bottom of excerpted articles

titlecase: true       # Converts page and post titles to titlecase

# list each of the sidebar modules you want to include, in the order you want them to appear.
# To add custom asides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
default_asides: [asides/recent_posts.html, asides/github.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html, asides/googleplus.html]

# Each layout uses the default asides, but they can have their own asides instead. Simply uncomment the lines below
# and add an array with the asides you want to use.
# blog_index_asides:
# post_asides:
# page_asides:

# ----------------------- #
#   3rd Party Settings    #
# ----------------------- #

# Github repositories
github_user: blogbin
github_repo_count: 0
github_show_profile_link: true
github_skip_forks: true

# Twitter
twitter_user: tech_blogbin
twitter_tweet_count: 4
twitter_show_replies: true
twitter_follow_button: true
twitter_show_follower_count: true
twitter_tweet_button: true

# Google +1
google_plus_one: true
google_plus_one_size: medium

# Google Plus Profile
# Hidden: No visible button, just add author information to search results
googleplus_user: tech.blogbin@gmail.com
googleplus_hidden: false

# Pinboard
pinboard_user:
pinboard_count: 3

# Delicious
delicious_user:
delicious_count: 3

# Disqus Comments
disqus_short_name: tech-blogbin-blog
disqus_show_comment_count: true

# Google Analytics
google_analytics_tracking_id: UA-34029049-1

# Facebook Like
facebook_like: true
```

注意，修改 _config.yml 等配置文件，必须重新编译生成静态文件，否则不会生效。

```
blogbins-MacBook-Pro:octopress blogbin$ rake generate
## Generating Site with Jekyll
unchanged sass/screen.scss
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/maruku-0.6.0/lib/maruku/input/parse_doc.rb:22:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
Configuration from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_config.yml
Building site: source -> public
Successfully generated site: source -> public
```

后推送到远端服务器

三. 问题

1. markdown 文件中在代码片段中错误指定语法格式，造成 rake generate 运行失效。

rake watch 和 rake preview 编译不会报错，所以发现改动一直没有更新，运行 rake generate 强制编译。

```
###```Bash shell scripts
blogbins-MacBook-Pro:octopress blogbin$ rake generate
```

报错信息如下：


```
## Generating Site with Jekyll
unchanged sass/screen.scss
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/maruku-0.6.0/lib/maruku/input/parse_doc.rb:22:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
Configuration from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_config.yml
Building site: source -> public
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/rubypython-0.5.3/lib/rubypython/rubypyproxy.rb:198:in `method_missing': ClassNotFound: no lexer for alias 'Bash' found (RubyPython::PythonError)
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/pygments.rb-0.2.13/lib/pygments/ffi.rb:135:in `lexer_for'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/pygments.rb-0.2.13/lib/pygments/ffi.rb:91:in `highlight'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/pygments_code.rb:24:in `pygments'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/pygments_code.rb:14:in `highlight'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/backtick_code_block.rb:37:in `block in render_code_block'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/backtick_code_block.rb:13:in `gsub'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/backtick_code_block.rb:13:in `render_code_block'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/octopress_filters.rb:12:in `pre_filter'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/octopress_filters.rb:28:in `pre_render'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/post_filters.rb:112:in `block in pre_render'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/post_filters.rb:111:in `each'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/post_filters.rb:111:in `pre_render'
     from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/plugins/post_filters.rb:166:in `do_layout'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/lib/jekyll/post.rb:189:in `render'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/lib/jekyll/site.rb:193:in `block in render'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/lib/jekyll/site.rb:192:in `each'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/lib/jekyll/site.rb:192:in `render'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/lib/jekyll/site.rb:40:in `process'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/jekyll-0.11.2/bin/jekyll:250:in `<top (required)>'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/bin/jekyll:19:in `load'
     from /Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/bin/jekyll:19:in `<main>'
blogbins-MacBook-Pro:octopress blogbin$ rake generate
## Generating Site with Jekyll
unchanged sass/screen.scss
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/maruku-0.6.0/lib/maruku/input/parse_doc.rb:22:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
Configuration from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_config.yml
Building site: source -> public
Successfully generated site: source -> public
```
