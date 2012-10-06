---
layout: post
title: "Rails Recipes Rails 3 Edition Recipe 4 Set Default Criteria for Model Operations"
date: 2012-10-07 00:13
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Rails Recipes Rails 3 Edition
- Recipe 4 Set Default Criteria for Model Operations
- Rails
tags: 
- Rails Recipes Rails 3 Edition
- Recipe 4 Set Default Criteria for Model Operations
- Rails
---

使用 default_scope 来设定 ActiveRecord 模型的默认查询条件。

先看一下之前用 scope 来实现的效果：
{% blockquote %}
set default criteria for model operations using Active Record’s
default_scope() method.

``` ruby rr2/default_scopes/app/models/product_first.rb
class Product < ActiveRecord::Base
	scope :available, where(:available => true)
end
```

<!--more-->

``` ruby
> Product.count
=> 6
> Product.available.count
=> 4
> Product.available.map(&:name)
=> ["Furbie",
"Godzilla",
"Mr. Bill",
"Cat Lady Action Figure"]
> Product.available.find_by_name("Godzilla")
=> #<Product id: 2, name: "Godzilla", ...>
```
{% endblockquote %}
每次都要调用一串 scope 定义的类方法，没有 DRY 。

重构用 default_scope 的效果：
{% blockquote %}
``` ruby rr2/default_scopes/app/models/product.rb
class Product < ActiveRecord::Base
	default_scope :available, where(:available => true)
end
```

``` ruby
> Product.all.map &:available
=> [true, true, true, true, true]
> Product.connection.execute("select count(*) from products")
=> [{"count(*)"=>11, 0=>11}]
> lb = Product.create(:name => "Liquid Brains",
:price => 19.74)
=> #<Product id: 12, ... updated_at: "2010-11-04 23:34:49">
> lb.available?
=> true
```
{% endblockquote %}

注意 default_scope 只影响默认查询条件，不会影响 create, new 等方法。如：
{% blockquote %}
``` ruby
> Product.create(:name => "Hideous Harvey",
:price => 2.99,
:available => false)
=> #<Product id: 13, name: "Hideous Harvey" ... >
> Product.find_by_id(13)
=> nil
> Product.unscoped { Product.find_by_id(13) }
=> #<Product id: 13, name: "Hideous Harvey" ...>
```
When we created the Product, this time we passed in an explicit value for the
available attribute. The default scope’s value doesn’t apply if you override it
explicitly. On our first attempt to find the record we just created, the query
responds as if the record doesn’t exist. When we bypass the default scope
with the unscoped() method, the record is returned.
{% endblockquote %}

使用 default_scope 可能会给其他人带来困扰。需要把握平衡。
{% blockquote %}
Without reading through your models, another programmer won’t know that
a default scope is implied.
use default scopes is a trade-off between convenience
and transparency.
{% endblockquote %}