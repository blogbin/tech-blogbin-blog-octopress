---
layout: post
title: "guides.rubyonrails.org association_basics"
date: 2012-10-04 10:34
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Ruby on Rails Guides A Guide to Active Record Associations
tags: 
- Ruby on Rails Guides A Guide to Active Record Associations
---

#### association_basics
学习 Rails ActiveRecord 中 has_many 的 :through, :as, source, :inverse_of 等几个参数的用法
<!--more-->

has_many 的 :through 可以快速获得嵌套 has_many 的对象。如：
{% blockquote %}
The has_many :through association is also useful for setting up “shortcuts” through nested has_many associations. For example, if a document has many sections, and a section has many paragraphs, you may sometimes want to get a simple collection of all paragraphs in the document. You could set that up this way:
```
class Document < ActiveRecord::Base
  has_many :sections
  has_many :paragraphs, :through => :sections
end
 
class Section < ActiveRecord::Base
  belongs_to :document
  has_many :paragraphs
end
 
class Paragraph < ActiveRecord::Base
  belongs_to :section
end
```
With :through => :sections specified, Rails will now understand:
```
@document.paragraphs
```
{% endblockquote %}
但如何直接赋值似乎成为一个问题，如：
```
@document.paragraphs = paragraphs
```

#### 泛型关联
polymorphic-associations
{% blockquote %}
2.9 Polymorphic Associations
A slightly more advanced twist on associations is the polymorphic association. With polymorphic associations, a model can belong to more than one other model, on a single association. For example, you might have a picture model that belongs to either an employee model or a product model. Here’s how this could be declared:
```
class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
end
 
class Employee < ActiveRecord::Base
  has_many :pictures, :as => :imageable
end
 
class Product < ActiveRecord::Base
  has_many :pictures, :as => :imageable
end
```
{% endblockquote %}

注意 Picture 的 :belong_to 和 Employee 以及 Product 的 :as 保持一致，都是 :imageable
{% blockquote %}
From an instance of the Employee model, you can retrieve a collection of pictures: @employee.pictures.

Similarly, you can retrieve @product.pictures.

If you have an instance of the Picture model, you can get to its parent via @picture.imageable. To make this work, you need to declare both a foreign key column and a type column in the model that declares the polymorphic interface:
```
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name
      t.integer :imageable_id
      t.string  :imageable_type
      t.timestamps
    end
  end
end
```
This migration can be simplified by using the t.references form:
```
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.references :imageable, :polymorphic => true
      t.timestamps
    end
  end
end
```
{% endblockquote %}
被关联的数据表（如 pictures）需要定义 xxx_id, xxx_type 两个字段（如 imageable_id, imageable_type )

[http://guides.rubyonrails.org/association_basics.html#polymorphic-associations](http://guides.rubyonrails.org/association_basics.html#polymorphic-associations)

#### has_many 的 :inverse_of 用法
{% blockquote %}
拿最简单的one-one来举例子吧：
User has_one Account
Account belongs_to User
在未设置:inverse_of的情况下：
```
u = User.first
[2] pry(main)> account = u.account
  Account Load (0.5ms)  SELECT `accounts`.* FROM `accounts` WHERE `accounts`.`id` = 2 LIMIT 1
[3] pry(main)> account.user
  User Load (0.6ms)  SELECT `users`.* FROM `users` WHERE `users`.`id` = 3 LIMIT 1
 ```

设置了inverse_of 以后：
```
class User < ActiveRecord::Base
  has_one :account, :inverse_of => :user
end
[1] pry(main)> u = User.first
  User Load (0.3ms)  SELECT `users`.* FROM `users` LIMIT 1
[2] pry(main)> account = u.account
  Account Load (0.1ms)  SELECT `accounts`.* FROM `accounts` WHERE `accounts`.`user_id` = 3 LIMIT 1
[3] pry(main)> account.user # No SQL Query
```
其中，把user.accout这一方法看成函数就是account(a_user) -> a_account
对应的反函数是user(a_account) 一定返回a_user
{% endblockquote %}
参阅：
[http://ruby-china.org/topics/5375](http://ruby-china.org/topics/5375)

#### 更多关于 has_many 等信息参阅：

[http://guides.rubyonrails.org/association_basics.html#the-has_many-association](http://guides.rubyonrails.org/association_basics.html#the-has_many-association

[http://guides.rubyonrails.org/association_basics.html#the-has_many-through-association](http://guides.rubyonrails.org/association_basics.html#the-has_many-through-association)

[http://guides.rubyonrails.org/association_basics.html#has_many-association-reference](http://guides.rubyonrails.org/association_basics.html#has_many-association-reference)
