---
layout: post
title: "Using Bitbucket"
date: 2012-08-31 22:41
comments: true
categories: 
- Bitbucket
- Git
tags: 
- Bitbucket
- Git
---
Bitbucket [https://bitbucket.org/](https://bitbucket.org/
)
是免费存放私人 Git 仓库的一个 GitHub 之外很好的选择。不限空间，不限项目。即使免费，也可以创建多个团队协助开发，
限制是每个团队人数不能超过 5 人。

是我提交／备份非公开项目的好地方。

Tech-blog 这个 Octopress 博客，已经部署／提交在多个 SaaS，故写一个 shell 脚本减轻工作量：
```
#! /bin/bash
git push

git push local master

git push heroku master

git push bitbucket master

rake deploy
```
