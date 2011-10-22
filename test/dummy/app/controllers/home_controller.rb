class HomeController < ApplicationController
  include Spike

  def index
    find first post
    # find all posts with id 15
  end
end