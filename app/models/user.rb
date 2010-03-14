class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :memberships, :class_name => "Group::Membership"
  has_many :my_groups, :class_name => "Group", :foreign_key => "creator_id"
  has_many :groups, :through => :memberships
  
  has_many :newsfeeds, :class_name => "NewsFeed", :foreign_key => "user_id"
  has_many :shares, :class_name => "Share", :foreign_key => "user_id"

  def fullname
    return "#{first_name} #{last_name}"
  end
  
  def is_member_of?(group)
    return group.members.include?(self)
  end
end
