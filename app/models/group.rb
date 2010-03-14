class Group < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  
  #Membership Associations
  has_many :memberships
  has_many :members, :through => :memberships, :source => :user
  
  #Share with Group Associations
  # has_many :share_with_groups, :class_name => "Share::ShareWithGroup", :foreign_key => "group_id"
  # has_many :shares, :through => :share_with_groups, :class_name => "Share", :foreign_key => "share_id"
  has_many :shares, :class_name => "Share", :foreign_key => "group_id"
  
  image_accessor :image
  
  def is_member_of?(user)
    return members.include?(user)
  end 
  alias :has_member? :is_member_of?
  
  def remove_member(user)
    return members.delete(user)
  end
  
  def generate_email
    self.email = name.downcase.gsub(' ', '')
  end
 
end

class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
end
