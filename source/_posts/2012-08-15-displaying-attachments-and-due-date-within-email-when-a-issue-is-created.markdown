---
layout: post
title: "Redmine 改进：新建问题发送邮件中显示完成时间和上传的附件信息"
date: 2012-08-15 23:44
comments: true
categories: 
- Redmine
- Ruby
- Rails
- RubyOnRails
- RoR
tags: 
- Redmine
- Ruby
- Rails
- RubyOnRails
- RoR
---

Redmine [http://www.redmine.org/](http://www.redmine.org/) 的确是一款优秀的任务跟踪管理系统，是开源免费，而且是基于 RubyOnRails 来开发的 Web 系统，代码具有很强的学习的价值。

很奇怪为何新建问题，系统自动发送的邮件没有显示要求完成时间和附件信息，而更新问题时发送的邮件却有两者信息。

阅读代码后发现，Redmine 负责渲染新建问题自动发送的邮件的地方，没有显示要求完成时间和附件信息。

要求完成时间比较好好处理，直接从 @issue.due_date 获得；

但新建问题后，就触发 Observer 自动发邮件，此时上传过的附件还没保存入库，所以利用现有途径无法从 @issue 获得附件。

尝试好几种方案，均不成功。最后考虑给 Issue 模型加一个实例变量临时保存附件信息。

Redmine 版本基于 1.2.1

与邮件正文内容显示相关的关键代码在 show_detail.rb 的 show_detail() 方法：

[https://github.com/redmine/redmine/blob/master/app/helpers/issues_helper.rb](https://github.com/redmine/redmine/blob/master/app/helpers/issues_helper.rb)


具体调整如下：

<!--more-->

##### 1. 打开 Issue 类，添加新的实例变量 original_attachments，用于临时保存刚上传的附件

``` ruby
class Issue < ActiveRecord::Base

  attr_accessor :original_attachments

end
```

##### 2. 修改 IssuesController#create 方法

``` ruby issues_controller.rb
def create
    call_hook(:controller_issues_new_before_save, { :params => params, :issue => @issue })

    # 对 @issue.original_attachments 进行赋值
    @issue.original_attachments = params[:attachments]

    if @issue.save

    # ... 以下省略
  end
```

##### 3. 渲染邮件格式的地方补充显示要求完成时间和附件信息 

``` ruby issue_add_text_html.rhtml
<%= l(:text_issue_added, :id => "##{@issue.id}", :author => h(@issue.author)) %>

<% 
  # 显示完成时间信息
  if @issue.due_date 
%>
<ul>
  <li><%= l(:text_journal_set_to, :label => l(:field_due_date), :value => format_date( @issue.due_date ) ) %> </li>
</ul>
<% end %>

<%
  # 显示附件信息
  attachments = @issue.original_attachments
  puts "attachments = #{attachments}"
  if attachments && attachments.is_a?(Hash)
%>
  	<ul>
			<%
		    attachments.each_value do |attachment|
		      file = attachment['file']
		      next unless file && file.size > 0
			%>
	  			<li><%= l(:text_journal_added, :label => l(:label_attachment), :value => file.original_filename ) %> </li>
	    <% end %>
  	</ul>
<% end %>

<hr />
<%= render :partial => "issue_text_html", :locals => { :issue => @issue, :issue_url => @issue_url } %>

```

##### 4. 最终效果如图
{% blockquote %}
{% img /images/2012-08-15-displaying-attachments-and-due-date-within-email-when-a-issue-is-created/redmine_issue_add_email.png %}
{% endblockquote %}
