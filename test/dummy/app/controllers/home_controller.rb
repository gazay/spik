class HomeController < ApplicationController
  include Spike

  def index
    Rails.logger.info '********* here we find all posts and write it in variable special_posts!'
    find all posts as special_posts with title 'asdf'
    Rails.logger.info '********* here we find first post from all posts!'
    find first post
    Rails.logger.info '********* here we find all posts from all posts!'
    find all posts
    Rails.logger.info '********* here we delete all posts with id 2'
    delete all posts with id 4
    delete post with id 5
  end

  def search
    Rails.logger.info '********* here we find all posts with title asdf2'
    find all posts which has title 'asdf2'
  end
end