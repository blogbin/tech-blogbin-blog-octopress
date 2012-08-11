---
layout: post
title: "Deploying to Github Pages"
date: 2012-08-11 23:13
comments: true
categories:
- Octopress
- GitHub
- Ruby
- Deployment
tags:
- Octopress
- GitHub
- Ruby
- Deployment
---

将 Octopress 部署到 GitHub，即同时支持 Hereku 和 GitHub。

Octopress 官方网站有文档详细说明，因此过程比较顺利。

<!--more-->

一. 前期准备

参阅：

[http://octopress.org/docs/deploying/github/](http://octopress.org/docs/deploying/github/)


二. 部署过程

先将本地 Octopress 备份

```
blogbins-MacBook-Pro:octopress blogbin$ pwd
/Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress

blogbins-MacBook-Pro:octopress blogbin$ cd ..
blogbins-MacBook-Pro:tech.blogbin blogbin$ ls
octopress
blogbins-MacBook-Pro:tech.blogbin blogbin$ cp -r octopress octopress.20120811
blogbins-MacBook-Pro:tech.blogbin blogbin$ ls
octopress		octopress.20120811

```

```
blogbins-MacBook-Pro:tech.blogbin blogbin$ cd octopress
Using /Users/blogbin/.rvm/gems/ruby-1.9.3-p0 with gemset octopress

blogbins-MacBook-Pro:octopress blogbin$ rake setup_github_pages
Enter the read/write url for your repository
(For example, 'git@github.com:your_username/your_username.github.com)
Repository url: git@github.com:blogbin/tech-blogbin-blog.git
rm -rf public
mkdir -p public/tech-blogbin-blog
## Site's root directory is now '/tech-blogbin-blog' ##
rm -rf _deploy
mkdir _deploy
cd _deploy
Initialized empty Git repository in /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_deploy/.git/
[master (root-commit) 4dda66a] Octopress init
 1 file changed, 1 insertion(+)
 create mode 100644 index.html
cd -

---
## Now you can deploy to http://blogbin.github.com/tech-blogbin-blog with `rake deploy` ##

blogbins-MacBook-Pro:octopress blogbin$ rake generate
## Generating Site with Jekyll
   remove .sass-cache/
   remove source/stylesheets/screen.css
   create source/stylesheets/screen.css
/Users/blogbin/.rvm/gems/ruby-1.9.3-p0@octopress/gems/maruku-0.6.0/lib/maruku/input/parse_doc.rb:22:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
Configuration from /Users/blogbin/projects/workspaces/octopress/tech.blogbin/octopress/_config.yml
Building site: source -> public/tech-blogbin-blog
Successfully generated site: source -> public/tech-blogbin-blog

blogbins-MacBook-Pro:octopress blogbin$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   Rakefile
#	modified:   _config.yml
#	modified:   config.rb
#	modified:   public/atom.xml
#	modified:   public/blog/2012/08/11/configuring-octopress-with-3rd-party-settings/index.html
#	modified:   public/blog/2012/08/11/how-to-install-octopress-on-heroku/index.html
#	modified:   public/blog/archives/index.html
#	modified:   public/blog/categories/configuration/atom.xml
#	modified:   public/blog/categories/configuration/index.html
#	modified:   public/blog/categories/heroku/atom.xml
#	modified:   public/blog/categories/heroku/index.html
#	modified:   public/blog/categories/installation/atom.xml
#	modified:   public/blog/categories/installation/index.html
#	modified:   public/blog/categories/octopress/atom.xml
#	modified:   public/blog/categories/octopress/index.html
#	modified:   public/blog/categories/ruby/atom.xml
#	modified:   public/blog/categories/ruby/index.html
#	modified:   public/index.html
#	modified:   public/stylesheets/screen.css
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	public/tech-blogbin-blog/
no changes added to commit (use "git add" and/or "git commit -a")

```

git://github.com/imathis/octopress.git 已经有 origin 改为 octopress

```

blogbins-MacBook-Pro:octopress blogbin$ git remote -v
heroku	git@heroku.com:tech-blogbin.git (fetch)
heroku	git@heroku.com:tech-blogbin.git (push)
octopress	git://github.com/imathis/octopress.git (fetch)
octopress	git://github.com/imathis/octopress.git (push)

```

本地机器已经存在公钥 id_rsa.pub ，但没有添加到 GitHub。
直接运行 rake deploy 提交会出现最后面的错误：Permission denied (publickey).

```
blogbins-MacBook-Pro:octopress blogbin$ ls ~/.ssh/ | grep id_rsa
id_rsa		id_rsa.pub
```

需要将本地机器 公钥 id_rsa.pub 提交到 GitHub
参阅：

[https://help.github.com/articles/generating-ssh-keys](https://help.github.com/articles/generating-ssh-keys)


并 skip to Step 4.

```
blogbins-MacBook-Pro:octopress blogbin$ pbcopy < ~/.ssh/id_rsa.pub
```

运行 rake deploy 部署至 GitHub。


```
blogbins-MacBook-Pro:octopress blogbin$ rake deploy
## Deploying branch to Github Pages
rm -rf _deploy/assets
rm -rf _deploy/atom.xml
rm -rf _deploy/blog
rm -rf _deploy/favicon.png
rm -rf _deploy/images
rm -rf _deploy/index.html
rm -rf _deploy/javascripts
rm -rf _deploy/sitemap.xml
rm -rf _deploy/stylesheets

## copying public/tech-blogbin-blog to _deploy
cp -r public/tech-blogbin-blog/. _deploy
cd _deploy

## Commiting: Site updated at 2012-08-11 13:47:38 UTC
# On branch gh-pages
nothing to commit (working directory clean)

## Pushing generated _deploy website
Counting objects: 102, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (92/92), done.
Writing objects: 100% (102/102), 204.84 KiB, done.
Total 102 (delta 13), reused 0 (delta 0)
To git@github.com:blogbin/tech-blogbin-blog.git
 * [new branch]      gh-pages -> gh-pages

## Github Pages deploy complete
cd -


```

向本地仓库提交变更。


```

blogbins-MacBook-Pro:octopress blogbin$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   Rakefile
#	modified:   _config.yml
#	modified:   config.rb
#	modified:   public/atom.xml
#	modified:   public/blog/2012/08/11/configuring-octopress-with-3rd-party-settings/index.html
#	modified:   public/blog/2012/08/11/how-to-install-octopress-on-heroku/index.html
#	modified:   public/blog/archives/index.html
#	modified:   public/blog/categories/configuration/atom.xml
#	modified:   public/blog/categories/configuration/index.html
#	modified:   public/blog/categories/heroku/atom.xml
#	modified:   public/blog/categories/heroku/index.html
#	modified:   public/blog/categories/installation/atom.xml
#	modified:   public/blog/categories/installation/index.html
#	modified:   public/blog/categories/octopress/atom.xml
#	modified:   public/blog/categories/octopress/index.html
#	modified:   public/blog/categories/ruby/atom.xml
#	modified:   public/blog/categories/ruby/index.html
#	modified:   public/index.html
#	modified:   public/stylesheets/screen.css
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	public/tech-blogbin-blog/
no changes added to commit (use "git add" and/or "git commit -a")
blogbins-MacBook-Pro:octopress blogbin$ git add .
blogbins-MacBook-Pro:octopress blogbin$ git commit -m 'update Github'
[master de0f825] update Github
 92 files changed, 11202 insertions(+), 47 deletions(-)
 rewrite public/stylesheets/screen.css (95%)
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/background.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/blankButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/divider.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/fullscreenButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/fullscreenButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/muteButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/muteButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/normalscreenButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/normalscreenButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/pauseButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/pauseButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/playButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/playButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/timeSliderBuffer.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/timeSliderCapLeft.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/timeSliderCapRight.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/timeSliderProgress.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/timeSliderRail.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/unmuteButton.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/controlbar/unmuteButtonOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/display/background.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/display/bufferIcon.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/display/muteIcon.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/display/playIcon.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/dock/button.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/glow.xml
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/item.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/itemOver.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/sliderCapBottom.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/sliderCapTop.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/sliderRail.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/playlist/sliderThumb.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/sharing/embedIcon.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/sharing/embedScreen.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/sharing/shareIcon.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/glow/sharing/shareScreen.png
 create mode 100644 public/tech-blogbin-blog/assets/jwplayer/player.swf
 create mode 100644 public/tech-blogbin-blog/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/2012/08/11/configuring-octopress-with-3rd-party-settings/index.html
 create mode 100644 public/tech-blogbin-blog/blog/2012/08/11/how-to-install-octopress-on-heroku/index.html
 create mode 100644 public/tech-blogbin-blog/blog/archives/index.html
 create mode 100644 public/tech-blogbin-blog/blog/categories/configuration/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/categories/configuration/index.html
 create mode 100644 public/tech-blogbin-blog/blog/categories/heroku/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/categories/heroku/index.html
 create mode 100644 public/tech-blogbin-blog/blog/categories/installation/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/categories/installation/index.html
 create mode 100644 public/tech-blogbin-blog/blog/categories/octopress/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/categories/octopress/index.html
 create mode 100644 public/tech-blogbin-blog/blog/categories/ruby/atom.xml
 create mode 100644 public/tech-blogbin-blog/blog/categories/ruby/index.html
 create mode 100644 public/tech-blogbin-blog/favicon.png
 create mode 100644 public/tech-blogbin-blog/images/bird_32_gray.png
 create mode 100644 public/tech-blogbin-blog/images/bird_32_gray_fail.png
 create mode 100644 public/tech-blogbin-blog/images/code_bg.png
 create mode 100644 public/tech-blogbin-blog/images/dotted-border.png
 create mode 100644 public/tech-blogbin-blog/images/email.png
 create mode 100644 public/tech-blogbin-blog/images/line-tile.png
 create mode 100644 public/tech-blogbin-blog/images/noise.png
 create mode 100644 public/tech-blogbin-blog/images/rss.png
 create mode 100644 public/tech-blogbin-blog/images/search.png
 create mode 100644 public/tech-blogbin-blog/index.html
 create mode 100644 public/tech-blogbin-blog/javascripts/ender.js
 create mode 100644 public/tech-blogbin-blog/javascripts/github.js
 create mode 100644 public/tech-blogbin-blog/javascripts/libs/ender.js
 create mode 100644 public/tech-blogbin-blog/javascripts/libs/jXHR.js
 create mode 100644 public/tech-blogbin-blog/javascripts/libs/swfobject-dynamic.js
 create mode 100644 public/tech-blogbin-blog/javascripts/modernizr-2.0.js
 create mode 100644 public/tech-blogbin-blog/javascripts/octopress.js
 create mode 100644 public/tech-blogbin-blog/javascripts/pinboard.js
 create mode 100644 public/tech-blogbin-blog/javascripts/twitter.js
 create mode 100644 public/tech-blogbin-blog/sitemap.xml
 create mode 100644 public/tech-blogbin-blog/stylesheets/screen.css

```


三. 问题

1. 错误：Permission denied (publickey).


```
blogbins-MacBook-Pro:octopress blogbin$ rake deploy
## Deploying branch to Github Pages
rm -rf _deploy/index.html

## copying public/tech-blogbin-blog to _deploy
cp -r public/tech-blogbin-blog/. _deploy
cd _deploy

## Commiting: Site updated at 2012-08-11 13:41:36 UTC
[gh-pages 68c6a21] Site updated at 2012-08-11 13:41:36 UTC
 73 files changed, 11155 insertions(+), 1 deletion(-)
 create mode 100644 assets/jwplayer/glow/controlbar/background.png
 create mode 100644 assets/jwplayer/glow/controlbar/blankButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/divider.png
 create mode 100644 assets/jwplayer/glow/controlbar/fullscreenButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/fullscreenButtonOver.png
 create mode 100644 assets/jwplayer/glow/controlbar/muteButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/muteButtonOver.png
 create mode 100644 assets/jwplayer/glow/controlbar/normalscreenButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/normalscreenButtonOver.png
 create mode 100644 assets/jwplayer/glow/controlbar/pauseButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/pauseButtonOver.png
 create mode 100644 assets/jwplayer/glow/controlbar/playButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/playButtonOver.png
 create mode 100644 assets/jwplayer/glow/controlbar/timeSliderBuffer.png
 create mode 100644 assets/jwplayer/glow/controlbar/timeSliderCapLeft.png
 create mode 100644 assets/jwplayer/glow/controlbar/timeSliderCapRight.png
 create mode 100644 assets/jwplayer/glow/controlbar/timeSliderProgress.png
 create mode 100644 assets/jwplayer/glow/controlbar/timeSliderRail.png
 create mode 100644 assets/jwplayer/glow/controlbar/unmuteButton.png
 create mode 100644 assets/jwplayer/glow/controlbar/unmuteButtonOver.png
 create mode 100644 assets/jwplayer/glow/display/background.png
 create mode 100644 assets/jwplayer/glow/display/bufferIcon.png
 create mode 100644 assets/jwplayer/glow/display/muteIcon.png
 create mode 100644 assets/jwplayer/glow/display/playIcon.png
 create mode 100644 assets/jwplayer/glow/dock/button.png
 create mode 100644 assets/jwplayer/glow/glow.xml
 create mode 100644 assets/jwplayer/glow/playlist/item.png
 create mode 100644 assets/jwplayer/glow/playlist/itemOver.png
 create mode 100644 assets/jwplayer/glow/playlist/sliderCapBottom.png
 create mode 100644 assets/jwplayer/glow/playlist/sliderCapTop.png
 create mode 100644 assets/jwplayer/glow/playlist/sliderRail.png
 create mode 100644 assets/jwplayer/glow/playlist/sliderThumb.png
 create mode 100644 assets/jwplayer/glow/sharing/embedIcon.png
 create mode 100644 assets/jwplayer/glow/sharing/embedScreen.png
 create mode 100644 assets/jwplayer/glow/sharing/shareIcon.png
 create mode 100644 assets/jwplayer/glow/sharing/shareScreen.png
 create mode 100644 assets/jwplayer/player.swf
 create mode 100644 atom.xml
 create mode 100644 blog/2012/08/11/configuring-octopress-with-3rd-party-settings/index.html
 create mode 100644 blog/2012/08/11/how-to-install-octopress-on-heroku/index.html
 create mode 100644 blog/archives/index.html
 create mode 100644 blog/categories/configuration/atom.xml
 create mode 100644 blog/categories/configuration/index.html
 create mode 100644 blog/categories/heroku/atom.xml
 create mode 100644 blog/categories/heroku/index.html
 create mode 100644 blog/categories/installation/atom.xml
 create mode 100644 blog/categories/installation/index.html
 create mode 100644 blog/categories/octopress/atom.xml
 create mode 100644 blog/categories/octopress/index.html
 create mode 100644 blog/categories/ruby/atom.xml
 create mode 100644 blog/categories/ruby/index.html
 create mode 100644 favicon.png
 create mode 100644 images/bird_32_gray.png
 create mode 100644 images/bird_32_gray_fail.png
 create mode 100644 images/code_bg.png
 create mode 100644 images/dotted-border.png
 create mode 100644 images/email.png
 create mode 100644 images/line-tile.png
 create mode 100644 images/noise.png
 create mode 100644 images/rss.png
 create mode 100644 images/search.png
 rewrite index.html (100%)
 create mode 100644 javascripts/ender.js
 create mode 100644 javascripts/github.js
 create mode 100644 javascripts/libs/ender.js
 create mode 100644 javascripts/libs/jXHR.js
 create mode 100644 javascripts/libs/swfobject-dynamic.js
 create mode 100644 javascripts/modernizr-2.0.js
 create mode 100644 javascripts/octopress.js
 create mode 100644 javascripts/pinboard.js
 create mode 100644 javascripts/twitter.js
 create mode 100644 sitemap.xml
 create mode 100644 stylesheets/screen.css

## Pushing generated _deploy website
Permission denied (publickey).
fatal: The remote end hung up unexpectedly

## Github Pages deploy complete
cd -

```