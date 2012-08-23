---
layout: post
title: "用 git-flow 进行分支操作"
date: 2012-08-23 22:28
comments: true
categories: 
- Git
- git-flow
tags:
- Git
- git-flow
---

参阅：

nvie/gitflow 
[https://github.com/nvie/gitflow/](https://github.com/nvie/gitflow/)

A successful Git branching model » nvie.com 
[http://nvie.com/posts/a-successful-git-branching-model/](http://nvie.com/posts/a-successful-git-branching-model/)

或者中文版

Git开发管理之道 - 无网不剩 
[http://blog.leezhong.com/translate/2010/10/30/a-successful-git-branch.html](http://blog.leezhong.com/translate/2010/10/30/a-successful-git-branch.html)

其实 git-flow 只是对 git 分支 checkout, 创建, merge 等命令进行包装，采用推荐的命令方式来使用优秀的分支创建和合并实践策略，
避免代码改动提交混乱，对本地仓库管理的代码几乎没有影响。

首先要明白 master 为产品分支，develop 为开发分支。
如果你以前采用 master 为主线或开发分支，产品分支为其他分支，脑筋要转过来。

<!--more-->

git flow 初始化本地仓库
```
blogbins-MacBook-Pro:octopress blogbin$ git flow init

Which branch should be used for bringing forth production releases?
   - master
Branch name for production releases: [master]
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? [] TEBN
blogbins-MacBook-Pro:octopress blogbin$ git status
# On branch develop
nothing to commit (working directory clean)
```

开始一个特性(octopress-indexer)开发
```
blogbins-MacBook-Pro:octopress blogbin$ git flow feature start octopress-indexer
Switched to a new branch 'feature/octopress-indexer'

Summary of actions:
- A new branch 'feature/octopress-indexer' was created, based on 'develop'
- You are now on branch 'feature/octopress-indexer'

Now, start committing on your feature. When done, use:

     git flow feature finish octopress-indexer
```

结束一个特性开发
```
blogbins-MacBook-Pro:octopress blogbin$ git flow feature finish octopress-indexer
Switched to branch 'develop'
Updating 024efad..6a21c04
Fast-forward
 plugins/indexer.rb                          |  255 +++++++++++++++++++++++++++
 source/_includes/custom/asides/indexer.html |   10 ++
 2 files changed, 265 insertions(+)
 create mode 100644 plugins/indexer.rb
 create mode 100644 source/_includes/custom/asides/indexer.html
Deleted branch feature/octopress-indexer (was 6a21c04).

Summary of actions:
- The feature branch 'feature/octopress-indexer' was merged into 'develop'
- Feature branch 'feature/octopress-indexer' has been removed
- You are now on branch 'develop'
```

手动将 develop 开发分支的改动 merge 回 master 产品分支
```
blogbins-MacBook-Pro:octopress blogbin$ git checkout master
Switched to branch 'master'

# 建议使用 --no-ff 选项，让 merge 也成为一个 commitment.
blogbins-MacBook-Pro:octopress blogbin$ git merge --no-ff develop
Merge made by the 'recursive' strategy.
 plugins/indexer.rb                          |  255 +++++++++++++++++++++++++++
 source/_includes/custom/asides/indexer.html |   10 ++
 2 files changed, 265 insertions(+)
 create mode 100644 plugins/indexer.rb
 create mode 100644 source/_includes/custom/asides/indexer.html
```

以上 git-flow 命令执行过程其实是对以下 git 命令的包装：

先基于 master 产品分支创建并切换到 develop 开发分支

git checkout -b develop master

开始开发一个新特性，基于 develop 创建新特性分支

git checkout -b feature/fengbin/using-git-flow develop

修改文件，提交文件。。。

切换回 develop 开发分支，将 using-git-flow 特性分支改动 merge 到 develop 开发分支

git checkout develop

git merge --no-ff feature/fengbin/using-git-flow

最后删除 using-git-flow 特性分支

git checkout -d feature/fengbin/using-git-flow develop



已有项目中初始化 git-flow 可能会出现以下错误： 

Local branch 'xxx' does not exist.
```
blogbins-MacBook-Pro:app_store blogbin$ git flow init

Which branch should be used for bringing forth production releases?
   - features/favorite
   - master
Branch name for production releases: [master] develop
Local branch 'develop' does not exist.
```

查阅 git-flow 官方教程或者网络资料，不管是已有项目或者新项目，初始化 git-flow 都是相同的命令 git flow init。

怀疑可能是本地仓库之前已经运行过 git flow init，随后有不按 git-flow 模式创建分支所致。

解决办法是，重现 git clone 远端仓库克隆出一个本地仓库，在本地仓库重新运行 git flow init。


