---
layout: post
title: "Hisea's Ruby和元编程的故事 - 第0回: 欲练神功，必先自废武功"
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

Ruby和元编程的故事 - 第0回: 欲练神功，必先自废武功

[http://ruby-china.org/topics/1171](http://ruby-china.org/topics/1171)

介绍了 Ruby 和元编程的一些特点，主要是在一些思维上的改变，特别是从 Java 等其它语言过来的人。

##### 1. 注意动态语言和动态类型的区别，动态类型仅为动态语言其中一个部分。
{% blockquote %}
动态语言:
动态语言的定义还很模糊，很多人把动态语言跟动态类型语言搞混，对于Hisea来说，动态语言就是类，方法，及其他定义可以在运行时进行改变，元编程就是利用这一特性。由此可见，动态语言跟动态类型语言并不是一个概念.
{% endblockquote %}


<!--more-->

##### 2. 推崇模块混入或者扩展的方式增加 API 功能，而非事事皆继承。
ps: 打开类也是一种途径。
{% blockquote %}
父类的作用仅仅是定义了API的存在，这在Java中是非常常见的，可是在Ruby中，这个父类其实存在的意义不是特别大。Ruby更倾向于,任何能起飞(拥有‘起飞’方法)的对象都是飞行器，而不是任何继承飞行器的类的对象。

  1. 需要用继承分享代码么？ ActiveRecord需要你继承ActiveRecord::Base,例如:
``` ruby
class Post < ActiveRecord::Base  
end
```
Hisea本人觉得类似Mongoid的Mixin方式更适合解决类似的问题。 Post从设计逻辑上来讲,跟ActiveRecord::Base没有半毛钱关系。继承关系完全用于分享代码，而在Ruby中，更好的分享代码的办法是用Mixin. 
{% endblockquote %}

##### 3. 个人认为 UML 仍是需要的
特别是项目中涉及到十几以上模型的时候，模型相互之间关系通过 UML 等方式更容易展现。关键是要及时更新和维护。
{% blockquote %}
4,忘记UML(或其他)设计大法
这个话题是3的继续，公司新招了一个Ruby程序员，他来了一两个星期后问了个问题，问为什么公司(或者其他Ruby程序员)不爱用UML之类的设计工具，当时我也一时找不出答案，后来开车回家的路上用半个小时想明白了，UML是一个类只见关系的静态表示，Ruby运行时的情况却是不停在变幻。用静态去表示动态，自然捉襟见肘。
{% endblockquote %}


##### 4. 好的 IDE 对 Ruby 开发有一定好处的
比如  RubyMine :  		

1. 调试功能不错，可以运行时调试，设置断点，查看变量。。。				
2. 支持一定类，模块，动法以及变量的查找，遇上 IDE 无法直接识别的，会列一个清单让用户选择

唯一不好的地方就是，RubyMine 是用 Java 做的，占内存，运行有时会卡，最好机器配置为 intel Core i5，8 G 内存以上，用 SSD 固态硬盘更好。

{% blockquote %}
5.为什么不用IDE?
很多从Java阵营转来，尤其是有多年eclipse经验的Ruby初学者尤其是经常爱问，Ruby用什么IDE。


得到的回答往往是text mate,vim,sublime text 2等等文本编辑器。


很多人可能纳闷，为什么Ruby/Rails没有一个IDE占领大片江山的情况，为什么Netbeans／Eclipse再Ruby开发阵营中没有其他语言开发占的地位重要。

其实答案很简单。


  1. IDE最讨喜的功能是什么？


很多用惯了IDE开发的Java程序员甚至XCode程序员，都会说最爱的功能是代码不全，object之后按一下'.'立马生成一个方法列表。转到Ruby用文本编辑器，没有这个功能，很是郁闷。其实道理很简单，如果方法都是动态生成的，在写程序的时候怎么能给出一个列表呢。


  2. Debugger还是必要工具么？


静态语言开发，调试是居家旅行杀人灭口必备良药。而IDE又是调试的好帮手。

Ruby／Rails的Debugger还没那么成熟，而且如果用logger, raise在适当的地方输出inspect, to_yaml等内容，也可以很容易的找到错误。


  3. Eclipse可以很好的配置Java开发环境。

Ruby/Rails有好用的RVM,RubyGems,Bundler.


所以，不补全，不调试，不配环境，要IDE不也是拿来当文本编辑器用么
{% endblockquote %}
