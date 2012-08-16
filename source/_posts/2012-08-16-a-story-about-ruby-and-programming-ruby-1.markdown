---
layout: post
title: "Hisea's Ruby和元编程的故事 - 第1回: 色色空空，万物皆为对象"
date: 2012-08-16 08:01
comments: true
external-url: http://ruby-china.org/topics/1171
categories: 
- Ruby
- MetaProgramming Ruby
tags: 
- Ruby
- MetaProgramming Ruby
---

参阅：
Hisea [http://hisea.me/](http://hisea.me/) 

Ruby和元编程的故事 - 第0回: 欲练神功，必先自废武功 [http://ruby-china.org/topics/1171](http://ruby-china.org/topics/1171)


##### 1. 官方说法是 eigenclass 本体类
有很多名字，比如单例类，估计是因为 eigenclass 本体类很容易就解决设计模式的单例，结果就误传下来了。
{% blockquote %}
Singleton/Meta/Anonymous/Ghost/Shadow Class

   * Singleton Class: 单例类
   * Meta Class：元类
   * Anonymous Class: 匿名类
   * Ghost Class：鬼类
   * Shadow Class: 影子类
上面的这些东东其实说的都是一个东西，我喜欢叫它 影子类。
{% endblockquote %}

<!--more-->

##### 2. 关于 Object#dup 和 Object#clone 的区别
{% blockquote %}
对象的复制
前文说对象的存在包括两部分，一是状态/实例变量，另一个是行为，本回专注讲了单例方法和影子类。

Ruby中对象的复制也有两种模式，一个是只复制当前的状态/实例变量 dup。另外一种是连同影子类和引用的对象一起复制，从而把单例方法也复制一份。
``` ruby
>> a = "obj"
>> def a.hello_self
>> puts "hello #{self}"
>> end
>> b = a.dup
=> "obj"
>> b.hello_self
NoMethodError: undefined method `hello_self' for "obj":String
    from (irb):90
>> b = a.clone
=> "obj"
>> b.hello_self
hello obj
```

其实有本回上述的这些功能，即便是没有class，Ruby也可以作为一种Prototype(类似JavaScript)的面向对象语言了。

你可以建立一个对象，生成默认的实例变量，把行为作为单例方法定以在这个对象的影子类上，然后用clone生成千千万万个实例。当然这样比较麻烦，但却是可行的途径之一。

其他Object API
对象还有很多其他的功能，比如可以freeze,另外dup跟clone也有一些其他的引用上面的区别，dup只复制引用，clone会吧引用的对象也复制。

这些都可以在Object类(Ruby所有对象的父类)API上找到，可以查看apidock.com的文档

例如关于dup

.dup() produces a shallow copy of obj—the instance variables of obj are copied, but not the objects they reference. dup copies the tainted state of obj. See also the discussion under Object#clone. In general, clone and dup may have different semantics in descendant classes. While clone is used to duplicate an object, including its internal state, dup typically uses the class of the descendant object to create the new instance.
{% endblockquote %}
