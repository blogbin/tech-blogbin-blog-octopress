---
layout: post
title: "元编程的魅力——反射机制 - 逸光 - (_2b || ! _2b).is_a? Question 读后感"
date: 2012-08-13 21:20
comments: true
external-url: http://www.slideshare.net/fullscreen/ihower/designing-ruby-apis/ 
categories: 
- Ruby
- MetaProgramming Ruby
tags: 
- Ruby
- MetaProgramming Ruby
---

  近期在准备 MetaProgramming Ruby 元编程的培训。除了 MetaProgramming Ruby 元编程这本书之外，想参阅一下其它资源，
作为培训 PPT 的补充。毕竟 MetaProgramming Ruby 元编程 虽然蕴含的知识量不小，但相比 Ruby 元编程本身，还是稍微有点薄。

[元编程的魅力——反射机制 - 逸光 - (_2b || ! _2b).is_a? Question](http://www.slideshare.net/fullscreen/ihower/designing-ruby-apis/) 的读后感：

<!--more-->

### 1. is_a?, kind_of? 和 instace_of? 的区别

{% blockquote %}
is_a?由Object类提供并接受一个参数，参数为类名的标识符（一个常量标识符），该方法用于确认对象是否为指定类的实例。区别与instance_of?，is_a?的判定条件比较宽松，ri提供的例子就足够详细了，让我们来看看吧。

```
module M; end
class A; include M; end
class B < A; end
class C < B; end

b = B.new
b.instance_of? A  #=> false
b.instance_of? B  #=> true
b.instance_of? C  #=> false
b.instance_of? M  #=> false

b.kind_of? A      #=> true
b.kind_of? B      #=> true
b.kind_of? C      #=> false
b.kind_of? M      #=> true
```

如果给定的类，是直接生成对象的类，那么，instance_of?方法才返回true。而如果是直接生成对象的类的父类或者引用的模块、父类引用的模块发，instance_of?就会无情的返回false。不过不要紧，kind_of?方法（is_a?方法也如此）会返回true的。

{% endblockquote %}

### 2. Module#included_modules 返回一个模块或类包含的模块

{% blockquote %}
module类的实例方法included_modules 可以返回一个模块或类包含的模块（Class继承自Module，自然继承了此方法）。
```
irb(main):033:0]]> B.included_modules
=> [M, Kernel]
```
Kernel模块，诚如教科书所写，他包含在每一个类或模块里，这样才使得Ruby中有了“函数”。
{% endblockquote %}

### 3. Fixnum 的对象和 Symbol 的对象一样不可变

{% blockquote %}
使用object_id获取对象的一个全局id，可以用于确定对象是不是同一个对象。
```
irb(main):010:0]]> 1.object_id == 1.object_id
=> true
 
irb(main):011:0]]> "obj".object_id == "obj".object_id
=> false
 
irb(main):012:0]]> :sym.object_id == :sym.object_id
=> true
```
　　Fixnum类的实例都是立即数因此只有一个副本，Symbol类的对象也一样，但是其他类的可能就不一样咯~
{% endblockquote %}