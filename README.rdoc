# Let spik with Rails!

The idea of this gem is experimenting with meta-programming abilities of Ruby. I want to talk with at first AR by imperative language.

## Usage

**This works fine only in production, because only in production we can get all models**

Firstly I should tell you about syntax. It's not really recipe from all problems, but now we can tell something to Rails:

1.  Simple select from table:

    ```ruby
    find all table_name
    ```

    for example with your table posts (and model Post):

    ```ruby
    find all posts
    ```

    After this you have initiated instance variable in your controller @posts, and you can use it in your views and later in controller

2.  Select first row from your table:

    ```ruby
    find first table_name_row
    ```

    for example with your table posts (and model Post):

    ```ruby
    find first post
    ```

    After this you have initiated instance variable in your controller @post, and you can use it in your views and later in controller

3.  Select rows from table with some condition:

    ```ruby
    find all table_name (with|which has|which have) (attribute_name) (id as numeric|'string in quotes')
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    find all posts with title 'asdf'
    ```

    After this you have initiated instance variable in your controller @posts, and you can use it in your views and later in controller

4.  Select rows from table with new name of instance variable:

    ```ruby
    find all table_name as what_you_want_your_variable_name (with|which has|which have) (attribute_name) (id as numeric|'string in quotes')
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    find all posts as special_posts
    ```

    After this you have initiated instance variable in your controller @special_posts, and you can use it in your views and later in controller

5.  Select rows from table with attribute like something:

    ```ruby
    find all table_name like attribute_name like 'something'
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    find all posts with title like 'asd'
    ```

    After this you have initiated instance variable in your controller @posts with items which have title like 'asd' (asdf|qweasdf|asd|...), and you can use it in your views and later in controller

## Older usage

If you want to get all your posts, you just include Spik module in controller and write 'find all posts':

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
gem 'spik', '0.0.1'
```

Or if you are old-school Rails 2 developer put this into `config/environment.rb` and run `$ rake gems:install`:

``` ruby
config.gem 'spik', :version => '0.0.1'
```

Or manually install spik gem: `$ gem install spik`

## Contributors

* @gazay
