---
layout: post
title: "sinaweibo python sdk"
date: 2012-08-18 20:57
comments: true
categories: 
- Sina Weibo SDK
- SNS
- Python
tags: 
- Sina Weibo SDK
- SNS
- Python
---

Python 客户端需要访问新浪微博 API，参照官方推荐的 Python SDK：

[http://michaelliao.github.com/sinaweibopy/d](http://michaelliao.github.com/sinaweibopy/)

发现自己使用的 Python 版本为 2.4，不支持 if ... then 同在一行的语法。调整举例：

``` python weibo.py https://github.com/blogbin/sinaweibopy/raw/9ea1bf949dbdf49153b50e9a2c787847d348fc9e/src/weibo.py
#data.append(v.encode('utf-8') if isinstance(v, unicode) else v)
if isinstance(v, unicode):
    data.append(v.encode('utf-8'))
else:
    data.append( v )   

```

在 GitHub 发起一个 Pull Request 请求：

[https://github.com/michaelliao/sinaweibopy/pull/2](https://github.com/michaelliao/sinaweibopy/pull/2)