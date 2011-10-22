class HomeController < ApplicationController
  include Spike

  def index
    find first post
    find all posts
  end

  def search
    find all posts which has title 'title of post2'
  end
end