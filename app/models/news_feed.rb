class NewsFeed < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  def by=(who)
    self.user = who
    return self
  end
end
