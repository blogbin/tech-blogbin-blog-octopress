---
layout: post
title: "Learning The Rspec Book"
date: 2012-09-28 10:11
comments: true
published: false
categories: 
---

Assertion becomes expectation.
• Test method becomes code example
• Test case becomes example group

The describe( ) method takes an arbitrary number of arguments and an
optional block and returns a subclass of RSpec::Core::ExampleGroup. We
typically use only one or two arguments, which represent the facet of
behavior that we want to describe.

```
describe "A User" { ... }
=> A User
describe User { ... }
=> User
describe User, "with no roles assigned" { ... }
=> User with no roles assigned
```