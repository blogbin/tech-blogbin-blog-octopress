---
layout: post
title: "申思维 @sg552sg552 meta ruby programming"
date: 2012-08-14 12:47
comments: true
external-url: http://ruby-china.org/topics/4662 
categories: 
- Ruby
- MetaProgramming Ruby
tags: 
- Ruby
- MetaProgramming Ruby
---

申思维 @sg552sg552 非常热情，主动告知我 PPT 的下载地址，非常感谢！ 

参阅：

[北京][2012年08月11日] Ruby 活动公告+媒体资料+小结 » 社区 | Ruby China
[http://ruby-china.org/topics/4662](http://ruby-china.org/topics/4662)

PPT：meta programming ruby // Speaker Deck
[https://speakerdeck.com/u/sg552sg552/p/meta-programming-ruby](https://speakerdeck.com/u/sg552sg552/p/meta-programming-ruby)

MP3：[http://vdisk.weibo.com/s/alUOz](http://vdisk.weibo.com/s/alUOz)

一些总结：

<!--more-->

##### 1. const_set 和 const_get 操作常量的用法

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/core_methods.jpeg %}
{% endblockquote %}

##### 2. 举例子说明：动态方法的好处，减少代码冗余

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/refactoring.jpeg %}
{% endblockquote %}

##### 3. %Q{} 语法使用，表示一行字符串

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/basic_class_eval.jpeg %}
{% endblockquote %}

##### 4. class_variables，class_variable_defined? 和 _get, _set 方法的使用

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/basic_class_variables.jpeg %}
{% endblockquote %}

##### 5. remove_const 和 const_set 对常量的动态操作

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/substitude_class.jpeg %}
{% endblockquote %}

想了半天才明白，Symbal 估计实现 Symbal#to_proc 方法：

``` ruby
class Symbal
  def to_proc
    Proc.new { | x | x.send self }
  end
end
```

##### 6. 适合迭代中，对每一个其中的元素做一次 Symbal 对象对应的方法调用。

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/symbol_to_proc.jpeg %}
{% endblockquote %}

##### 7. stub 方法实现测试中 Mock 的功能，估计 stub 方法实现是通过 Module#define_method 重新定义了方法，返回代码块执行的结果。

{% blockquote %}
{% img /images/2012-08-14-shen-si-wei-at-sg552sg552-meta-ruby-programming/symbol_to_proc.jpeg %}
{% endblockquote %}