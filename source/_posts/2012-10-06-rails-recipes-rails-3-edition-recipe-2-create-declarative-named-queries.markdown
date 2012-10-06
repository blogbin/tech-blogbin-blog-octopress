---
layout: post
title: "Rails Recipes Rails 3 Edition Recipe 2 Create Declarative Named Queries"
date: 2012-10-06 17:12
comments: true
author: Tech.Blogbin <tech.blogbin@gmail.com>
categories: 
- Rails Recipes Rails 3 Edition
- Recipe 2 Create Declarative Named Queries
- Rails
tags: 
- Rails Recipes Rails 3 Edition
- Recipe 2 Create Declarative Named Queries
- Rails
---

ActiveRecord Scope 是定义查询相关类方法的一种快捷方式。

以下代码，模型查询或业务逻辑代码暴露在 controller
{% blockquote %}
``` ruby rr2/declarative_scopes/app/controllers/wombats_controller.rb
class WombatsController < ApplicationController
	def search
		@wombats = Wombat.where("bio like ?", "%#{params[:q]}%").
		order(:age)
		render :index
	end
end
```
{% endblockquote %}

重构将模型查询或业务逻辑代码封装在 model 类中，如： 
<!--more-->
{% blockquote %}
``` ruby rr2/declarative_scopes/app/controllers/wombats_controller.rb
def search
	@wombats = Wombat.with_bio_containing(params[:q])
	render :index
end
```

```  ruby rr2/declarative_scopes/app/models/wombat.rb
class Wombat < ActiveRecord::Base
	def self.with_bio_containing(query)
		where("bio like ?", "%#{query}%").
		order(:age)
	end
end
```
{% endblockquote %}

改用 scope 来定义与查询相关的方法，如
{% blockquote %}
``` ruby rr2/declarative_scopes/app/models/wombat.rb
class Wombat < ActiveRecord::Base
	scope :with_bio_containing, lambda {|query| where("bio like ?", "%#{query}%").
	order(:age) }
end
```
{% endblockquote %}

scope 方法返回 ActiveRecord::Relation，采用延迟加载的方式。
{% blockquote %}
You see here that a call to our teenagers() scope actually returns an instance
of ActiveRecord::Relation, not an Array of Person objects! We can ask an ActiveRecord::Relation
to convert itself to SQL with the to_sql() method. If we combine two scopes,
you see that the ActiveRecord::Relation objects actually combine to generate one
composed query.
{% endblockquote %}

更多 ActiveRecord Scope 信息参见：
[http://guides.rubyonrails.org/active_record_querying.html#scopes](http://guides.rubyonrails.org/active_record_querying.html#scopes)