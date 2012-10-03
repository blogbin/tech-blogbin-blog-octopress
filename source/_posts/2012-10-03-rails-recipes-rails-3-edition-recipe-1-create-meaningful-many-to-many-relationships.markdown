---
layout: post
title: "Rails Recipes Rails 3 Edition Recipe 1 Create Meaningful Many-to-Many Relationships"
date: 2012-10-03 23:50
comments: true
published: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Rails Recipes Rails 3 Edition
- Recipe 1 Create Meaningful Many-to-Many Relationships
- Rails
tags: 
- Rails Recipes Rails 3 Edition
- Recipe 1 Create Meaningful Many-to-Many Relationships
- Rails
---

Rails 中 ActiveRecord 两个模型之间的多对多关系很少简单用 has_and_belong_to_many 来表示，而是引入第三个模型（关联模型），将之前 A 和 B 的多对多关系，拆分为 A 和 C 的一对多，
B 和 C 的一对多。引入新的关联模型 C ，很容易在 A 和 B 关系上定义一些属性。

<!--more-->

{% blockquote %}
When modeling many-to-many relationships in Rails, many newcomers
assume they should use the has_and_belongs_to_many() (habtm) macro with its
associated join table. For years, application developers have been creating
strangely named join tables in order to simply connect two tables. But habtm
is best suited to relationships that have no attributes or meaning of their own.
And, given some thought, almost every relationship in a Rails model deserves
its own name to represent its function in the domain being modeled.

The idea with join models is that if your many-to-many relationship needs to have some richness
in the association, instead of putting a simple, dumb join table in the middle
of the relationship,
{% endblockquote %}

migrate 创建 关联表（just simply connect two tables） 可以不需要定义 id 主键
``` ruby rr2/many_to_many/beginning_schema.rb
create_table :magazines_readers, :id => false do |t|
	t.integer :magazine_id
	t.integer :reader_id
end
```
参阅：
{% blockquote %}
By default, create_table will create a primary key called id. You can change the name of the primary key with the :primary_key option (don’t forget to update the corresponding model) or, if you don’t want a primary key at all (for example for a HABTM join table), you can pass the option :id => false. If you need to pass database specific options you can place an SQL fragment in the :options option. For example,

create_table :products, :options => "ENGINE=BLACKHOLE" do |t|
  t.string :name, :null => false
end
will append ENGINE=BLACKHOLE to the SQL statement used to create the table (when using MySQL, the default is ENGINE=InnoDB).
{% endblockquote %}
[http://guides.rubyonrails.org/migrations.html#creating-a-table](http://guides.rubyonrails.org/migrations.html#creating-a-table)

一个 Association 可以根据需要定义不同的 has_many，如：
``` ruby ManyToManyWithAttributesOnTheRelationship/app/models/magazine.rb
class Magazine < ActiveRecord::Base
	has_many :subscriptions
	has_many :readers, :through => :subscriptions
	has_many :semiannual_subscribers,
		:through => :subscriptions,
		:source => :reader,
		:conditions => ['length_in_issues = 6']
end
```

更多关于 has_many 和 :through 信息参阅：

[http://guides.rubyonrails.org/association_basics.html#the-has_many-association](http://guides.rubyonrails.org/association_basics.html#the-has_many-association

[http://guides.rubyonrails.org/association_basics.html#the-has_many-through-association](http://guides.rubyonrails.org/association_basics.html#the-has_many-through-association)

[http://guides.rubyonrails.org/association_basics.html#has_many-association-reference](http://guides.rubyonrails.org/association_basics.html#has_many-association-reference)
