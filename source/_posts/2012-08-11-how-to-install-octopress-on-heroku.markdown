---
layout: post
title: "How to Install Octopress on Heroku"
date: 2012-08-11 11:08
comments: true
categories:
- Octopress
- Heroku
- Ruby
- Installation
- Deployment
tags:
- Octopress
- Heroku
- Ruby
- Installation
- Deployment
---

我选择 Octopress 作为搭建技术博客的理由：

1. 基于我最喜爱编程语言：Ruby 语言；
2. 支持 unix shell 命令操作，比传统仅能使用 Web UI 界面管理更加灵活和可控，但上手很容易，操作并不繁琐；
3. 本地和远端都能用 Git 分布式版本系统来管理，减低数据丢失风险，并能通过 Git 和 Rsync 等技术快速部署到远端多个服务器，包括物理服务器， IAAS 和 PAAS；
4. 对内嵌代码片段的具有独特的风格展现（支持 Markdown 语法），代码容易阅读和分享，这是编程类技术博客最看重的优势之一；
5. 最终生成静态页面，对服务器部署没有特别的要求

下面是安装 Octopress，并部署到 Heroku 的过程。

<!--more-->

一. 前期准备

参阅教程：

[http://octopress.org/docs/setup/](http://octopress.org/docs/setup/)

[http://octopress.org/docs/deploying/heroku](http://octopress.org/docs/deploying/heroku)

[https://devcenter.heroku.com/articles/quickstart](https://devcenter.heroku.com/articles/quickstart)

[https://devcenter.heroku.com/articles/renaming-apps](https://devcenter.heroku.com/articles/renaming-apps)


二. 操作过程

使用 RVM 为 Octopress 创建新的 Gemset：

```
blogbins-MacBook-Pro:octopress blogbin$ pwd
/Users/blogbin/projects/workspaces/octopress/tech.blogbin
blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm list

rvm rubies

   ruby-1.8.7-p357 [ i686 ]
   ruby-1.9.3-p0 [ x86_64 ]

# Default ruby not set. Try 'rvm alias create default <ruby>'.

# => - current
# =* - current && default
#  * - default

blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm use 1.9.3
Using /Users/blogbin/.rvm/gems/ruby-1.9.3-p0
blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm gemset create octopress
'octopress' gemset created (/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress).
blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm useruby-1.9.3-p0@octopress
blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm ruby-1.9.3-p0@octopress
blogbins-MacBook-Pro:tech.blogbin blogbin$ rvm use ruby-1.9.3-p0@octopress
Using /Users/blogbin/.rvm/gems/ruby-1.9.3-p0 with gemset octopress
blogbins-MacBook-Pro:tech.blogbin blogbin$ git clone git://github.com/imathis/octopress.git octopress
Cloning into 'octopress'...
remote: Counting objects: 7027, done.
remote: Compressing objects: 100% (2546/2546), done.
remote: Total 7027 (delta 4052), reused 6578 (delta 3834)
Receiving objects: 100% (7027/7027), 1.40 MiB | 95 KiB/s, done.
Resolving deltas: 100% (4052/4052), done.
blogbins-MacBook-Pro:tech.blogbin blogbin$ cd octopress
==============================================================================
= NOTICE                                                                     =
==============================================================================
= RVM has encountered a new or modified .rvmrc file in the current directory =
= This is a shell script and therefore may contain any shell commands.       =
=                                                                            =
= Examine the contents of this file carefully to be sure the contents are    =
= safe before trusting it! ( Choose v[iew] below to view the contents )      =
==============================================================================
Do you wish to trust this .rvmrc file? (/Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/.rvmrc)
y[es], n[o], v[iew], c[ancel]> yes
Using /Users/blogbin/.rvm/gems/ruby-1.9.3-p0

blogbins-MacBook-Pro:octopress blogbin$ vi .rvmrc
rvm use ruby-1.9.3-p0@octopress

blogbins-MacBook-Pro:octopress blogbin$ cd ..

blogbins-MacBook-Pro:tech.blogbin blogbin$ cd octopress/
==============================================================================
= NOTICE                                                                     =
==============================================================================
= RVM has encountered a new or modified .rvmrc file in the current directory =
= This is a shell script and therefore may contain any shell commands.       =
=                                                                            =
= Examine the contents of this file carefully to be sure the contents are    =
= safe before trusting it! ( Choose v[iew] below to view the contents )      =
==============================================================================
Do you wish to trust this .rvmrc file? (/Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/.rvmrc)
y[es], n[o], v[iew], c[ancel]> yes
Using /Users/blogbin/.rvm/gems/ruby-1.9.3-p0 with gem set octopuses

blogbins-MacBook-Pro:octopress blogbin$ gem install bundler
Fetching: bundler-1.1.4.gem (100%)
Successfully installed bundler-1.1.4
1 gem installed
Installing ri documentation for bundler-1.1.4...
Installing RDoc documentation for bundler-1.1.4...
blogbins-MacBook-Pro:octopress blogbin$ bundle install
Fetching gem metadata from http://rubygems.org/.......
Installing rake (0.9.2.2)
Installing RedCloth (4.2.9) with native extensions
Installing posix-spawn (0.3.6) with native extensions
Installing albino (1.3.3)
Installing blankslate (2.1.2.4)
Installing chunky_png (1.2.5)
Installing fast-stemmer (1.0.1) with native extensions
Installing classifier (1.3.3)
Installing fssm (0.2.9)
Installing sass (3.1.20)
Installing compass (0.12.2)
Installing directory_watcher (1.4.1)
Installing ffi (1.0.11) with native extensions
Installing haml (3.1.6)
Installing kramdown (0.13.7)
Installing liquid (2.3.0)
Installing syntax (1.0.0)
Installing maruku (0.6.0)
Installing jekyll (0.11.2)
Installing rubypython (0.5.3)
Installing pygments.rb (0.2.13)
Installing rack (1.4.1)
Installing rack-protection (1.2.0)
Installing rb-fsevent (0.9.1)
Installing rdiscount (1.6.8) with native extensions
Installing rubypants (0.2.0)
Installing tilt (1.3.3)
Installing sinatra (1.3.2)
Installing stringex (1.4.0)
Using bundler (1.1.4)
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.


blogbins-MacBook-Pro:octopress blogbin$ rake install
## Copying classic theme into ./source and ./sass
mkdir -p source
cp -r .themes/classic/source/. source
mkdir -p sass
cp -r .themes/classic/sass/. sass
mkdir -p source/_posts
mkdir -p public


blogbins-MacBook-Pro:octopress blogbin$ gem install heroku
Fetching: excon-0.15.4.gem (100%)
Fetching: heroku-api-0.2.13.gem (100%)
Fetching: netrc-0.7.5.gem (100%)
Fetching: mime-types-1.19.gem (100%)
Fetching: rest-client-1.6.7.gem (100%)
Fetching: addressable-2.2.8.gem (100%)
Fetching: launchy-2.1.0.gem (100%)
Fetching: rubyzip-0.9.9.gem (100%)
Fetching: heroku-2.28.12.gem (100%)
Successfully installed excon-0.15.4
Successfully installed heroku-api-0.2.13
Successfully installed netrc-0.7.5
Successfully installed mime-types-1.19
Successfully installed rest-client-1.6.7
Successfully installed addressable-2.2.8
Successfully installed launchy-2.1.0
Successfully installed rubyzip-0.9.9
Successfully installed heroku-2.28.12
9 gems installed
Installing ri documentation for excon-0.15.4...
Installing ri documentation for heroku-api-0.2.13...
Installing ri documentation for netrc-0.7.5...
Installing ri documentation for mime-types-1.19...
Installing ri documentation for rest-client-1.6.7...
Installing ri documentation for addressable-2.2.8...
Installing ri documentation for launchy-2.1.0...
Installing ri documentation for rubyzip-0.9.9...
Installing ri documentation for heroku-2.28.12...
Installing RDoc documentation for excon-0.15.4...
Installing RDoc documentation for heroku-api-0.2.13...
Installing RDoc documentation for netrc-0.7.5...
Installing RDoc documentation for mime-types-1.19...
Installing RDoc documentation for rest-client-1.6.7...
Installing RDoc documentation for addressable-2.2.8...
Installing RDoc documentation for launchy-2.1.0...
Installing RDoc documentation for rubyzip-0.9.9...
Installing RDoc documentation for heroku-2.28.12…


```

登陆 Heroku 。请预先创建 Heroku 帐户。


```

blogbins-MacBook-Pro:octopress blogbin$ heroku login
Enter your Heroku credentials.
Email: tech.blogbin@gmail.com
Password (typing will be hidden):
Found the following SSH public keys:
1) github_rsa.pub
2) id_rsa.pub
Which would you like to use with your Heroku account? 2
Uploading SSH public key /Users/blogbin/.ssh/id_rsa.pub... done
Authentication successful.

blogbins-MacBook-Pro:octopress blogbin$ heroku create
Creating afternoon-journey-1049... done, stack is cedar
http://afternoon-journey-1049.herokuapp.com/ | git@heroku.com:afternoon-journey-1049.git
Git remote heroku added
blogbins-MacBook-Pro:octopress blogbin$ git remote -v
heroku     git@heroku.com:afternoon-journey-1049.git (fetch)
heroku     git@heroku.com:afternoon-journey-1049.git (push)
origin     git://github.com/imathis/octopress.git (fetch)
origin     git://github.com/imathis/octopress.git (push)


blogbins-MacBook-Pro:octopress blogbin$ vi .gitignore

.bundle
.DS_Store
.sass-cache
.gist-cache
.pygments-cache
_deploy
#public
sass.old
source.old
source/_stash
source/stylesheets/screen.css
vendor
node_modules

blogbins-MacBook-Pro:octopress blogbin$ rake generate
## Generating Site with Jekyll
directory source/stylesheets/
   create source/stylesheets/screen.css
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/maruku-0.6.0/lib/maruku/input/parse_doc.rb:22:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
Configuration from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_config.yml
Building site: source -> public
Successfully generated site: source -> public
blogbins-MacBook-Pro:octopress blogbin$ git add .
blogbins-MacBook-Pro:octopress blogbin$ git commit -m 'site updated'
[master be4b9a0] site updated
 181 files changed, 7019 insertions(+), 2 deletions(-)
 create mode 100644 public/assets/jwplayer/glow/controlbar/background.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/blankButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/divider.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/fullscreenButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/fullscreenButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/muteButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/muteButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/normalscreenButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/normalscreenButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/pauseButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/pauseButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/playButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/playButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/timeSliderBuffer.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/timeSliderCapLeft.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/timeSliderCapRight.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/timeSliderProgress.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/timeSliderRail.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/unmuteButton.png
 create mode 100644 public/assets/jwplayer/glow/controlbar/unmuteButtonOver.png
 create mode 100644 public/assets/jwplayer/glow/display/background.png
 create mode 100644 public/assets/jwplayer/glow/display/bufferIcon.png
 create mode 100644 public/assets/jwplayer/glow/display/muteIcon.png
 create mode 100644 public/assets/jwplayer/glow/display/playIcon.png
 create mode 100644 public/assets/jwplayer/glow/dock/button.png
 create mode 100644 public/assets/jwplayer/glow/glow.xml
 create mode 100644 public/assets/jwplayer/glow/playlist/item.png
 create mode 100644 public/assets/jwplayer/glow/playlist/itemOver.png
 create mode 100644 public/assets/jwplayer/glow/playlist/sliderCapBottom.png
 create mode 100644 public/assets/jwplayer/glow/playlist/sliderCapTop.png
 create mode 100644 public/assets/jwplayer/glow/playlist/sliderRail.png
 create mode 100644 public/assets/jwplayer/glow/playlist/sliderThumb.png
 create mode 100644 public/assets/jwplayer/glow/sharing/embedIcon.png
 create mode 100644 public/assets/jwplayer/glow/sharing/embedScreen.png
 create mode 100644 public/assets/jwplayer/glow/sharing/shareIcon.png
 create mode 100644 public/assets/jwplayer/glow/sharing/shareScreen.png
 create mode 100644 public/assets/jwplayer/player.swf
 create mode 100644 public/atom.xml
 create mode 100644 public/blog/archives/index.html
 create mode 100644 public/favicon.png
 create mode 100644 public/images/bird_32_gray.png
 create mode 100644 public/images/bird_32_gray_fail.png
 create mode 100644 public/images/code_bg.png
 create mode 100644 public/images/dotted-border.png
 create mode 100644 public/images/email.png
 create mode 100644 public/images/line-tile.png
 create mode 100644 public/images/noise.png
 create mode 100644 public/images/rss.png
 create mode 100644 public/images/search.png
 create mode 100644 public/index.html
 create mode 100644 public/javascripts/ender.js
 create mode 100644 public/javascripts/github.js
 create mode 100644 public/javascripts/libs/ender.js
 create mode 100644 public/javascripts/libs/jXHR.js
 create mode 100644 public/javascripts/libs/swfobject-dynamic.js
 create mode 100644 public/javascripts/modernizr-2.0.js
 create mode 100644 public/javascripts/octopress.js
 create mode 100644 public/javascripts/pinboard.js
 create mode 100644 public/javascripts/twitter.js
 create mode 100644 public/sitemap.xml
 create mode 100644 public/stylesheets/screen.css
 create mode 100644 sass/_base.scss
 create mode 100644 sass/_partials.scss
 create mode 100644 sass/base/_layout.scss
 create mode 100644 sass/base/_solarized.scss
 create mode 100644 sass/base/_theme.scss
 create mode 100644 sass/base/_typography.scss
 create mode 100644 sass/base/_utilities.scss
 create mode 100644 sass/custom/_colors.scss
 create mode 100644 sass/custom/_fonts.scss
 create mode 100644 sass/custom/_layout.scss
 create mode 100644 sass/custom/_styles.scss
 create mode 100644 sass/partials/_archive.scss
 create mode 100644 sass/partials/_blog.scss
 create mode 100644 sass/partials/_footer.scss
 create mode 100644 sass/partials/_header.scss
 create mode 100644 sass/partials/_navigation.scss
 create mode 100644 sass/partials/_sharing.scss
 create mode 100644 sass/partials/_sidebar.scss
 create mode 100644 sass/partials/_syntax.scss
 create mode 100644 sass/partials/sidebar/_base.scss
 create mode 100644 sass/partials/sidebar/_delicious.scss
 create mode 100644 sass/partials/sidebar/_googleplus.scss
 create mode 100644 sass/partials/sidebar/_pinboard.scss
 create mode 100644 sass/partials/sidebar/_twitter.scss
 create mode 100644 sass/screen.scss
 create mode 100644 source/_includes/after_footer.html
 create mode 100644 source/_includes/archive_post.html
 create mode 100644 source/_includes/article.html
 create mode 100644 source/_includes/asides/delicious.html
 create mode 100644 source/_includes/asides/github.html
 create mode 100644 source/_includes/asides/googleplus.html
 create mode 100644 source/_includes/asides/pinboard.html
 create mode 100644 source/_includes/asides/recent_posts.html
 create mode 100644 source/_includes/asides/twitter.html
 create mode 100644 source/_includes/custom/after_footer.html
 create mode 100644 source/_includes/custom/asides/about.html
 create mode 100644 source/_includes/custom/category_feed.xml
 create mode 100644 source/_includes/custom/footer.html
 create mode 100644 source/_includes/custom/head.html
 create mode 100644 source/_includes/custom/header.html
 create mode 100644 source/_includes/custom/navigation.html
 create mode 100644 source/_includes/disqus.html
 create mode 100644 source/_includes/facebook_like.html
 create mode 100644 source/_includes/footer.html
 create mode 100644 source/_includes/google_analytics.html
 create mode 100644 source/_includes/google_plus_one.html
 create mode 100644 source/_includes/head.html
 create mode 100644 source/_includes/header.html
 create mode 100644 source/_includes/navigation.html
 create mode 100644 source/_includes/post/author.html
 create mode 100644 source/_includes/post/categories.html
 create mode 100644 source/_includes/post/date.html
 create mode 100644 source/_includes/post/disqus_thread.html
 create mode 100644 source/_includes/post/sharing.html
 create mode 100644 source/_includes/twitter_sharing.html
 create mode 100644 source/_layouts/category_index.html
 create mode 100644 source/_layouts/default.html
 create mode 100644 source/_layouts/page.html
 create mode 100644 source/_layouts/post.html
 create mode 100644 source/assets/jwplayer/glow/controlbar/background.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/blankButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/divider.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/fullscreenButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/fullscreenButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/muteButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/muteButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/normalscreenButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/normalscreenButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/pauseButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/pauseButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/playButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/playButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/timeSliderBuffer.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/timeSliderCapLeft.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/timeSliderCapRight.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/timeSliderProgress.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/timeSliderRail.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/unmuteButton.png
 create mode 100644 source/assets/jwplayer/glow/controlbar/unmuteButtonOver.png
 create mode 100644 source/assets/jwplayer/glow/display/background.png
 create mode 100644 source/assets/jwplayer/glow/display/bufferIcon.png
 create mode 100644 source/assets/jwplayer/glow/display/muteIcon.png
 create mode 100644 source/assets/jwplayer/glow/display/playIcon.png
 create mode 100644 source/assets/jwplayer/glow/dock/button.png
 create mode 100644 source/assets/jwplayer/glow/glow.xml
 create mode 100644 source/assets/jwplayer/glow/playlist/item.png
 create mode 100644 source/assets/jwplayer/glow/playlist/itemOver.png
 create mode 100644 source/assets/jwplayer/glow/playlist/sliderCapBottom.png
 create mode 100644 source/assets/jwplayer/glow/playlist/sliderCapTop.png
 create mode 100644 source/assets/jwplayer/glow/playlist/sliderRail.png
 create mode 100644 source/assets/jwplayer/glow/playlist/sliderThumb.png
 create mode 100644 source/assets/jwplayer/glow/sharing/embedIcon.png
 create mode 100644 source/assets/jwplayer/glow/sharing/embedScreen.png
 create mode 100644 source/assets/jwplayer/glow/sharing/shareIcon.png
 create mode 100644 source/assets/jwplayer/glow/sharing/shareScreen.png
 create mode 100644 source/assets/jwplayer/player.swf
 create mode 100644 source/atom.xml
 create mode 100644 source/blog/archives/index.html
 create mode 100644 source/favicon.png
 create mode 100644 source/images/bird_32_gray.png
 create mode 100644 source/images/bird_32_gray_fail.png
 create mode 100644 source/images/code_bg.png
 create mode 100644 source/images/dotted-border.png
 create mode 100644 source/images/email.png
 create mode 100644 source/images/line-tile.png
 create mode 100644 source/images/noise.png
 create mode 100644 source/images/rss.png
 create mode 100644 source/images/search.png
 create mode 100644 source/index.html
 create mode 100644 source/javascripts/ender.js
 create mode 100644 source/javascripts/github.js
 create mode 100644 source/javascripts/libs/ender.js
 create mode 100644 source/javascripts/libs/jXHR.js
 create mode 100644 source/javascripts/libs/swfobject-dynamic.js
 create mode 100644 source/javascripts/modernizr-2.0.js
 create mode 100644 source/javascripts/octopress.js
 create mode 100644 source/javascripts/pinboard.js
 create mode 100644 source/javascripts/twitter.js


```

推送到 Heroku 远端仓库


```


blogbins-MacBook-Pro:octopress blogbin$ git push heroku master
Counting objects: 4035, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (1418/1418), done.
Writing objects: 100% (4035/4035), 928.25 KiB | 69 KiB/s, done.
Total 4035 (delta 2310), reused 3968 (delta 2289)

-----> Heroku receiving push
-----> Ruby/Rack app detected
-----> Installing dependencies using Bundler version 1.2.0.rc
       Running: bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment
       Fetching gem metadata from http://rubygems.org/.....
       Installing rack (1.4.1)
       Installing rack-protection (1.2.0)
       Installing tilt (1.3.3)
       Installing sinatra (1.3.2)
       Using bundler (1.2.0.rc)
       Your bundle is complete! It was installed into ./vendor/bundle
       Cleaning up the bundler cache.
-----> Discovering process types
       Procfile declares types     -> (none)
       Default types for Ruby/Rack -> console, rake, web
-----> Compiled slug size is 884K
-----> Launching... done, v3
       http://tech-blogbin.herokuapp.com deployed to Heroku

To git@heroku.com:tech-blogbin.git
 * [new branch]      master -> master

```

现在可以访问 http://tech-blogbin.herokuapp.com/

三. 问题

1. 没有选择默认 SSH 公钥造成的困扰

造成 git push heroku master 推送不成功


```

blogbins-MacBook-Pro:octopress blogbin$ heroku login
Enter your Heroku credentials.
Email: tech.blogbin@gmail.com
Password (typing will be hidden):
Found the following SSH public keys:
1) github_rsa.pub
2) id_rsa.pub
Which would you like to use with your Heroku account? 1
Uploading SSH public key /Users/blogbin/.ssh/github_rsa.pub... done
Authentication successful.


blogbins-MacBook-Pro:octopress blogbin$ git push heroku master
The authenticity of host 'heroku.com (50.19.85.154)' can't be established.
RSA key fingerprint is .
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'heroku.com,50.19.85.154' (RSA) to the list of known hosts.
Permission denied (publickey).
fatal: The remote end hung up unexpectedly



blogbins-MacBook-Pro:octopress blogbin$ vi ~/.ssh/config

Host heroku.com
        HostName heroku.com
        User tech.blogbin@gmail.com
        IdentityFile ~/.ssh/github_rsa.pub


blogbins-MacBook-Pro:octopress blogbin$ git push heroku master
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for '/Users/blogbin/.ssh/github_rsa.pub' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
bad permissions: ignore key: /Users/blogbin/.ssh/github_rsa.pub
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
blogbins-MacBook-Pro:octopress blogbin$ chmod 600 /Users/blogbin/.ssh/github_rsa.pub
blogbins-MacBook-Pro:octopress blogbin$ git push heroku master
Warning: Permanently added the RSA host key for IP address '50.19.85.132' to the list of known hosts.
Permission denied (publickey).
fatal: The remote end hung up unexpectedly

blogbins-MacBook-Pro:octopress blogbin$ heroku keys:add
Found the following SSH public keys:
1) github_rsa.pub
2) id_rsa.pub
Which would you like to use with your Heroku account? 2
Uploading SSH public key /Users/blogbin/.ssh/id_rsa.pub... done
blogbins-MacBook-Pro:octopress blogbin$ heroku keys
=== tech.blogbin@gmail.com Keys
ssh-rsa ... GitHub@blogbin
ssh-rsa .. blogbin@blogbins-MacBook-Pro.local

blogbins-MacBook-Pro:octopress blogbin$ heroku keys:remove GitHub@blogbin
Removing GitHub@blogbin SSH key… done

```

2. Heroku Web 界面修改 app-name 造成本地仓库无法推送 Heroku 远端仓库

关于 app-name 更名，建议参阅 https://devcenter.heroku.com/articles/renaming-apps

Web 界面 app-name 从 afternoon-journey-1049 更名为 tech-blogbin 造成的困扰

```

blogbins-MacBook-Pro:octopress blogbin$ git push heroku master

 !  No such app as afternoon-journey-1049.

fatal: The remote end hung up unexpectedly


```

删除本地 Git 的 heroku 远程引用，并添加新的 heroku 远程引用: git@heroku.com:tech-blogbin.git


```

blogbins-MacBook-Pro:octopress blogbin$ git remote rm heroku
blogbins-MacBook-Pro:octopress blogbin$ git remote add heroku git@heroku.com:tech-blogbin.git

blogbins-MacBook-Pro:octopress blogbin$ git remote -v
heroku     git@heroku.com:tech-blogbin.git (fetch)
heroku     git@heroku.com:tech-blogbin.git (push)
origin     git://github.com/imathis/octopress.git (fetch)
origin     git://github.com/imathis/octopress.git (push)
blogbins-MacBook-Pro:octopress blogbin$ git push heroku master
Counting objects: 4035, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (1418/1418), done.
Writing objects: 100% (4035/4035), 928.25 KiB | 69 KiB/s, done.
Total 4035 (delta 2310), reused 3968 (delta 2289)

-----> Heroku receiving push
-----> Ruby/Rack app detected
-----> Installing dependencies using Bundler version 1.2.0.rc
       Running: bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment
       Fetching gem metadata from http://rubygems.org/.....
       Installing rack (1.4.1)
       Installing rack-protection (1.2.0)
       Installing tilt (1.3.3)
       Installing sinatra (1.3.2)
       Using bundler (1.2.0.rc)
       Your bundle is complete! It was installed into ./vendor/bundle
       Cleaning up the bundler cache.
-----> Discovering process types
       Procfile declares types     -> (none)
       Default types for Ruby/Rack -> console, rake, web
-----> Compiled slug size is 884K
-----> Launching... done, v3
       http://tech-blogbin.herokuapp.com deployed to Heroku

To git@heroku.com:tech-blogbin.git
 * [new branch]      master -> master

```