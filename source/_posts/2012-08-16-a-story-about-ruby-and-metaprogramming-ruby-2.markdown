---
layout: post
title: "Hisea's Ruby和元编程的故事 - 第2回: 类与模块，Ruby的绝代双骄"
date: 2012-08-16 16:22
comments: true
external-url: http://ruby-china.org/topics/1581
categories: 
- Ruby
- MetaProgramming Ruby
tags: 
- Ruby
- MetaProgramming Ruby
---

参阅：
Hisea [http://hisea.me/](http://hisea.me/) 

Ruby和元编程的故事 - 第2回: 类与模块，Ruby的绝代双骄 [http://ruby-china.org/topics/1581](http://ruby-china.org/topics/1581)


##### 1. 注意向已有的常量再次赋值很容易引起错误，所以 Ruby 语言会自动警告提示该情况
有很多名字，比如单例类，估计是因为 eigenclass 本体类很容易就解决设计模式的单例，结果就误传下来了。

{% blockquote %}
实际上，如果已经存在一个同名常量，Ruby会重新使用那个常量,如果常量不是class就会报错>> Test = 2
``` ruby
=> 2
>> class Test
>> end
TypeError: Test is not a class
from (irb):2
```
{% endblockquote %}

<!--more-->

##### 2. Module 的模块方法可以直接被调用
{% blockquote %}
module的方法有两种，一种是module方法，这类方法可以直接调用。
``` ruby
>> module Test
>>   def Test.test_method
>>     puts "hello from module"
>>   end
>> end
=> nil
>> Test::test_method
hello from module 
=> nil
```
{% endblockquote %}