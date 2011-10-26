class Post < ActiveRecord::Base
  scope :titles, where(:title => 'asdf')
  scope :popular, where(:title => 'asdf')

  def self.all_titles
    find(:all).map{|it| it.title}
  end
end