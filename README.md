# Let spik with Rails!

You can use this gem for making beautiful thin and elegant speaking with
humans controllers. Just imagine if your action instead of this:

```ruby
def index
  @posts = Post.all(
    :conditions => {:something => params[:something]},
    :order => 'id desc',
    :limit => 20 ).
      map{ |it| it.name.uppercase + '#' + it.short_description }.
      uniq
end
```

Might look like this:

```ruby
def index
  find some posts with something like params[:something]
end
```

Of course you should create scope in your model for that. And of course
I know that with this scope you can write your controller's action like
this:

```ruby
def index
  @posts = Post.some params[:something]
end
```

Yeah! It's short, and readable from some side. But! You free to screw it
up with additional excess logic here! You can add some filters maybe.
Maybe you will create another one variable. Maybe use here some methods
or somethig. THINK ABOUT THIN AND ELEGANT CONTROLLERS! Logic should be
in models and presenters! SHOULD BE!

So my gem do an unnatural borders for you. You can create cool
controllers with only 2-3 lines of each action. With my gem you SHOULD
organize your logic into model methods/scopes and into presenters. Try
it!

### Usage in project

If you want to get all your posts, you just include Spik module in controller and write 'find all posts':

*app/controllers/home_controller.rb*

```ruby
class HomeController < ApplicationController
  include Spik

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

*app/views/home/index.html.erb*

```erb
<h1>Hello Spik!</h1>
<%- if @posts %>
  <%= @posts.size %>
<%- end %>
<%- if @post %>
  <%= @post.title %>
<%- end %>
```

## Installation

Puts this line into `Gemfile` then run `$ bundle`:

``` ruby
gem 'spik', '0.0.3'
```

Or if you are old-school Rails 2 developer put this into `config/environment.rb` and run `$ rake gems:install`:

``` ruby
config.gem 'spik', :version => '0.0.3'
```

Or manually install spik gem: `$ gem install spik`

## Contributors

* @gazay
