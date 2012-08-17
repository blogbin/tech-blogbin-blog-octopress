---
layout: post
title: "softwareishard's introduction to firebug net panel"
date: 2012-08-17 23:06
comments: true
categories: 
- Firebug
- Firefox
- Net
---

Firebug 监控浏览器的网络请求，softwareishard 网站有很详细的介绍。

[http://www.softwareishard.com/blog/firebug/introduction-to-firebug-net-panel/](http://www.softwareishard.com/blog/firebug/introduction-to-firebug-net-panel/)

[http://www.softwareishard.com/blog/firebug/firebug-net-panel-timings/](http://www.softwareishard.com/blog/firebug/firebug-net-panel-timings/)

甚至比 Firebug 官方 Wiki [http://getfirebug.com/wiki/index.php/Net_Panel](http://getfirebug.com/wiki/index.php/Net_Panel) 都要详细。

特别留意一下 DomContentLoaded event 和 load event 代表的意思，其它都比较好理解。

{% blockquote %}
DomContentLoaded event 
- time when DomContentLoad event was fired (since the beginning of the request, can be negative if the request has been started after the event)

load event 
- time when page load event was fired (since the beginning of the request, can be negative if the request has been started after the event)
{% endblockquote %}
