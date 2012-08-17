---
layout: post
title: "Ruby元编程 - 逸光 - 我信仰超越光的不是物质，是思维"
date: 2012-08-17 09:36
comments: true
external-url: http://deathking.is-programmer.com/posts/28864.html
categories: 
- Ruby
- MetaProgramming Ruby
tags: 
- Ruby
- MetaProgramming Ruby
---

参阅：
逸光 [http://deathking.is-programmer.com//](http://deathking.is-programmer.com/) 

Ruby元编程 - 逸光 - 我信仰超越光的不是物质，是思维 [http://deathking.is-programmer.com/posts/28864.html](http://deathking.is-programmer.com/posts/28864.html)


##### 1. 慎用 eval

{% blockquote %}
一般来说，能避免 eval 就尽量避免，因为 eval 有额外的“分析时”开销（将字符串作为源代码进行词法、文法分析），而这个“剖析时”却又是在程序“运行时”进行的。把不需要惰性求值的表达式预先进行及早求值，能避免一些分析时开销。如果可能的话，用 instance_exec，或 instance_eval 带块的形式，也比直接在字符串上求值好。
{% endblockquote %}

<!--more-->

##### 2. 一句话明了 class_eval 的区别
{% blockquote %}
当作用于类时，class_eval将会定义实例方法，而instance_eval定义类方法。
{% endblockquote %}

##### 3. class_variables 操作的是类变量，而非类实例变量
{% blockquote %}
1.3.9 class_variables 
　　如果你想知道一个类中有哪些类变量，我们可以使用class_varibles方法。他返回一个数组（Array），以符号（Symbol）的形式返回类变量的名称。
```
classRubyist
  @@geek="Ruby's Matz"
  @@country="USA"
end
 

classChild < Rubyist
  @@city="Nashville"
end
print Rubyist.class_variables# => [:@@geek, :@@country]
puts
p Child.class_variables# => [:@@city]
```
　　你可以从程序的输出中观察到Child.class_variables输出的是在Child类中定义的类变量（@@city）。Child类没有从父类中继承类变量（@@geek, @@country）。
{% endblockquote %}


##### 4. 常量操作 const_get 和 const_set
{% blockquote %}
1.3.11 const_get, const_set

　　类似的，const_get和const_set用于操作常量。const_get返回指定常量的值：

``` ruby
puts Float.const_get(:MIN) # => 2.2250738585072e-308
```
　　const_set为指定的常量设置指定的值，并返回该对象。如果常量不存在，那么他会创建该常量，就是下面示范的那样：
``` ruby
class Rubyist

end
puts Rubyist.const_set("PI", 22.0/7.0) # => 3.14285714285714
```

　　因为const_get返回常量的值，因此，你可以使用此方法获得一个类的名字并为这个类添加一个新的实例化对象的方法。这样使得我们有能力在运行时创建类并实例化其实例。
``` ruby
# Let us call our new class 'Rubyist'
# (we could have prompted the user for a class name)
class_name = "rubyist".capitalize

Object.const_set(class_name, Class.new)

# Let us create a method 'who'
# (we could have prompted the user for a method name)
class_name = Object.const_get(class_name)

puts class_name # => Rubyist

class_name.class_eval do

  define_method :who do |my_arg|

    my_arg
  end
end
obj = class_name.new
puts obj.who('Matz') # => Matz
```
{% endblockquote %}




