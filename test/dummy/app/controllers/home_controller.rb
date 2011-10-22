class HomeController < ApplicationController
  include Spike

  def index
    find first post
    delete all posts
  end
end