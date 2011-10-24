# Let spik with Rails!

The idea of this gem is experimenting with meta-programming abilities of Ruby. I want to talk with at first AR by imperative language.

## Usage

**This works fine only in production, because only in production we can get all models**

Firstly I should tell you about syntax. It's not really recipe from all problems, but now we can tell something to Rails:

### Select

1.  Simple select from table:

    ```ruby
    # regular variant:
    @table_name = TableName.find(:all)

    # with Spik:
    find all table_name
    ```

    for example with your table posts (and model Post):

    ```ruby
    # regular variant:
    @posts = Post.find(:all)

    # with Spik:
    find all posts
    ```

    After this you have initiated instance variable in your controller @posts, and you can use it in your views and later in controller

2.  Select first row from your table:

    ```ruby
    # regular variant:
    @table_name_row = TableName.find(:first)

    # with Spik:
    find first table_name_row
    ```

    for example with your table posts (and model Post):

    ```ruby
    # regular variant:
    @post = Post.find(:first)

    # with Spik:
    find first post
    ```

    After this you have initiated instance variable in your controller @post, and you can use it in your views and later in controller

3.  Select rows from table with some condition:

    ```ruby
    # regular variant:
    @table_name = TableName.find(:all, :conditions => ['attribute = ?', value])

    # with Spike:
    find all table_name (with|which has|which have) (attribute_name) (id as numeric|'string in quotes')
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    # regular variant:
    @posts = Post.find(:all, :conditions => ['title = ?', 'asdf'])

    # with Spik:
    find all posts with title 'asdf'
    ```

    After this you have initiated instance variable in your controller @posts, and you can use it in your views and later in controller

4.  Select rows from table with new name of instance variable:

    ```ruby
    # regular variant:
    @what_you_want_your_variable_name = TableName.find(:all)

    # with Spik:
    find all table_name as what_you_want_your_variable_name (with|which has|which have) (attribute_name) (id as numeric|'string in quotes')
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    # regular variant:
    @special_posts = Post.find(:all)

    # with Spik:
    find all posts as special_posts
    ```

    After this you have initiated instance variable in your controller @special_posts, and you can use it in your views and later in controller

5.  Select rows from table with attribute like something:

    ```ruby
    # regular variant:
    @table_name = TableName.find(:all, :conditions => ['attribute LIKE "%?%"', value])

    # with Spik:
    find all table_name with attribute_name like 'something'
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    # regular variant:
    @posts = Post.find(:all, :conditions => ['title LIKE "%?%"', 'asd'])

    # with Spik:
    find all posts with title like 'asd'
    ```

    After this you have initiated instance variable in your controller @posts with items which have title like 'asd' (asdf|qweasdf|asd|...), and you can use it in your views and later in controller

### Delete

1.  Delete all rows from table with attribute equals something:

    ```ruby
    # regular variant:
    TableName.delete_all(['attribute = ?', value])

    # with Spik:
    delete all table_name with attribute_name 'something'
    ```

    for example with your table posts (and model Post) and table has attribute title:

    ```ruby
    # regular variant:
    Post.delete_all(['title = ?', 'asd'])

    # with Spik:
    delete all posts with title 'asd'
    ```

    After this all posts rows with title 'asd' will be deleted

2.  Delete row from table with specific id:

    ```ruby
    # regular variant:
    TableName.delete(id)

    # with Spik:
    delete [first] table_name_row with id (numeric)
    ```

    for example with your table posts (and model Post):

    ```ruby
    # regular variant:
    Post.delete(5)

    # with Spik:
    delete post with id 5
    ```

    After this post row with id 5 will be deleted

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
gem 'spik', '0.0.1'
```

Or if you are old-school Rails 2 developer put this into `config/environment.rb` and run `$ rake gems:install`:

``` ruby
config.gem 'spik', :version => '0.0.1'
```

Or manually install spik gem: `$ gem install spik`

## Contributors

* @gazay
