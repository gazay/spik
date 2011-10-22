# Let spike with Rails!

The idea of this gem is experimenting with meta-programming abilities of Ruby. I want to talk with at first AR by imperative language.

## Usage

If you want to get all your posts, you just include Spike module in controller and write 'find all posts':

```ruby
class HomeController < ApplicationController
  include Spike

  def index
    find first post
    find all posts
  end

  def search
    find all posts with title params[:post_title]
  end
end
```

After that you can work with variables @post and @posts:

```erb
<h1>Hello Spike!</h1>
<%- if @posts %>
  <%= @posts.size %>
<%- end %>
<%- if @post %>
  <%= @post.title %>
<%- end %>
```

## Installation

This gem has no version now. I just start my experiment ;)

## Contributors

* @gazay
