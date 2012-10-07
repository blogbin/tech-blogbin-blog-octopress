---
layout: post
title: "Rails Recipes Rails 3 Edition Recipe 5 Add Behavior to Active Record Associations"
date: 2012-10-07 00:35
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Rails Recipes Rails 3 Edition
- Recipe 5 Add Behavior to Active Record Associations
- Rails
tags: 
- Rails Recipes Rails 3 Edition
- Recipe 5 Add Behavior to Active Record Associations
- Rails
---

ActiveRecord 有两种办法为 Association 增加行为或方法。先看一下 Association 增加的 create 方法：
{% blockquote %}
``` ruby 
$ rails console
>> me = Student.create(:name => "Chad", :graduating_year => 2020)
=> #<Student:0x26d18d8 @new_record=false, @attributes={"name"=>"Chad",
"id"=>1, "graduating_year"=>2020}>
>> me.grades.create(:score => 1, :class_name => "Algebra")
=> #<Grade:0x269cb10 @new_record=false, @errors={}>, @attributes={"score"=>1,
"class_name"=>"Algebra", "student_id"=>1, "id"=>1}>
```

<!--more-->

``` ruby
>> me.grades.class
=> Array
>> Array.instance_methods.grep /create/
=> []
```
{% endblockquote %}

xxx.class 返回是 Array，但其实是 ActiveRecord::Associations::CollectionProxy 对象，它把 .class 的调用转发给封装的 Array 对象。
{% blockquote %}
The collection returned by an Active Record association isn’t actually an Array.
It’s a collection proxy. Collection proxies are wrappers around the collections,
allowing them to be lazily loaded and extended. To add behavior to an Active
Record association, you add it to the collection proxy during the call to
has_many().

What’s really going on is that the call to grades() returns an instance of
ActiveRecord::Associations::CollectionProxy. This sits between your model’s client code
and the actual objects the model is associated with. It masquerades as an
object of the class you expect (Array in this example) and delegates calls to the
appropriate application-specific model objects.

Since each access to an association can create
a new instance of CollectionProxy, we can’t just get the association via a call to
grades() and add our behaviors to it. Active Record controls the creation and
return of these objects, so we’ll need to ask Active Record to extend the proxy
object for us.
{% endblockquote %}

两种途径：
1. has_many 的 :extend 参数指定一个 Module
{% blockquote %}
Active Record gives us two ways to accomplish this. First, we
could define additional methods in a module and then extend the association
proxy with that module.

``` ruby rr2/assoc_proxies/lib/grade_finder.rb
module GradeFinder
	def below_average
	where('score < ?', 2)
	end
end
```

``` ruby rr2/assoc_proxies/app/models/student.rb
require "grade_finder"
class Student < ActiveRecord::Base
	has_many :grades, :extend => GradeFinder
end
```

``` ruby
$ rails console
>> Student.first.grades.below_average
=> [#<Grade:0x26aecc0 @attributes={"score"=>"1",
"student_id"=>"1", "id"=>"1"}>]
```
{% endblockquote %}

2. has_many 传入一个代码块，代码块中定义方法
{% blockquote %}
Alternatively, we could have defined this method directly by passing a block
to the declaration of the has_many() association:
``` ruby rr2/assoc_proxies/app/models/student.rb
class Student < ActiveRecord::Base
	has_many :grades do
		def below_average
			where('score < ?', 2)
		end
	end
end
```
{% endblockquote %}

有意思的是，扩展模块或代码块中定义方法上下文中, self 指向 Array 对象，而不是 Proxy 对象本身.
{% blockquote %}
These association proxies have access to all the same methods that would
normally be defined on the associations, such as find(), count(), and create().
An interesting point to notice is that inside the scope of one of these extended
methods, the special variable self refers to the Array of associated Active Record
objects. This means you can index into the array and perform any other
operations on self that you could perform on an array.
{% endblockquote %}

如果要访问代理对象或者 Association 两边的对象，可通过 proxy_association 相关的属性和方法。
{% blockquote %}
Extensions can refer to the internals of the association proxy using these three attributes of the proxy_association accessor:

proxy_association.owner returns the object that the association is a part of.
proxy_association.reflection returns the reflection object that describes the association.
proxy_association.target returns the associated object for belongs_to or has_one, or the collection of associated objects for has_many or has_and_belongs_to_many.
{% endblockquote %}

关于 has_many 的 :extend 更多信息，参阅：
[http://guides.rubyonrails.org/association_basics.html#association-extensions](http://guides.rubyonrails.org/association_basics.html#association-extensions)