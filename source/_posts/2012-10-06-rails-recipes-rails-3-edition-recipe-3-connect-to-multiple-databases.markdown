---
layout: post
title: "Rails Recipes Rails 3 Edition Recipe 3 Connect to Multiple Databases"
date: 2012-10-06 19:58
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Rails Recipes Rails 3 Edition
- Recipe 3 Connect to Multiple Databases
- Rails
tags: 
- Rails Recipes Rails 3 Edition
- Recipe 3 Connect to Multiple Databases
- Rails
---
Rails 项目中同时连接多个数据库的办法。

Rails 项目启动时, ActiveRecord::Railtie 调用 ActiveRecord::Base 的 establish_connection 方法来初始化数据库连接。
{% blockquote %}
In Rails 3 and newer, this process
does its work by delegating to each subframework of Rails and asking that
subframework to initialize itself. Each of these initializers is called a Railtie.
Active Record defines ActiveRecord::Railtie to play the initialization role. One of
its jobs is to initialize database connections.

So, in the default case, all your models get access to this default connection.
If you make a connection from one of your model classes (by calling establish_connection()),
that connection is available from that class and any of its children
but not from its superclasses, including ActiveRecord::Base.

When asked for its connection, the behavior of a model is to start with the
exact class the request is made from and work its way up the inheritance
hierarchy until it finds a connection. This is a key point in working with
multiple databases. A model’s connection applies to that model and any of
its children in the hierarchy unless overridden.
{% endblockquote %}

<!--more-->

通过调用 establish_connection 方法来连接外部数据库
{% blockquote %}
``` ruby rr2/multiple_dbs/app/models/plain_product.rb
class Product < ActiveRecord::Base
	establish_connection :products	
end
```
{% endblockquote %}

建议为外部数据库的数据，提供对应的本地映射表和模型。如果可能，保持本地映射表和模型只读状态。
{% blockquote %}
we’ll create a mapping table in our
application’s default database (the same one the cart table exists in):
``` ruby rr2/multiple_dbs/db/migrate/20101128145152_create_product_references.rb
class CreateProductReferences < ActiveRecord::Migration
	def self.up
		create_table :product_references do |t|
		t.integer :product_id
		t.timestamps
		end
	end
	def self.down
		drop_table :product_references
	end
end
```
This table’s sole purpose is to provide a local reference to a product. The
product’s id will be stored in the product reference’s product_id field.
{% endblockquote %}

可以创建一个专门连接其它数据库的模型类（抽象的，不需要对应数据表），并创建相应的子类。
{% blockquote %}
``` ruby rr2/multiple_dbs/app/models/external.rb
class External < ActiveRecord::Base
	self.abstract_class = true
	establish_connection :products
end
```

``` ruby ConnectingToMultipleDatabases/app/models/product.rb
class Product < External
end
```

``` ruby rr2/multiple_dbs/app/models/tax_conversion.rb
class TaxConversion < External
end
```
{% endblockquote %}

访问其它数据库的另外方法：
{% blockquote %}
If you have to continue using an external database, you might consider
exposing that data as a REST service, allowing access only via HTTP calls as
Connect to Multiple Databases
opposed to direct database access. For read-only feeds of data that need to
participate in complex joins, consider replicating the data from its source
table to the databases that need to use it.
{% endblockquote %}

exposing that data as a REST service，可以使用 Rails 提供的 ActiveResouce。可参阅：

[http://api.rubyonrails.org/classes/ActiveResource/Base.html](http://api.rubyonrails.org/classes/ActiveResource/Base.html)

[https://github.com/rails/activeresource](https://github.com/rails/activeresource)