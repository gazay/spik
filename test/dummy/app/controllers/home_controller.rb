class HomeController < ApplicationController
  include Spike

  def index
    find first post
    find all posts with title 'asdfasdf'
  end
end