class HomeController < ApplicationController
  include Spike

  def index
    find first post
    find all posts
  end
end