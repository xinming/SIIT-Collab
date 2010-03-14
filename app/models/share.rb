class Share < ActiveRecord::Base
  # Set the class name of the content before validation
  belongs_to :content, :polymorphic => true, :dependent => :destroy
  serialize :options
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  # Share with Group Associations (Implementation later)
  # has_many :share_with_groups, :class_name => "ShareWithGroup", :foreign_key => "share_id"
  # has_many :groups, :through => :share_with_groups, :class_name => "Group", :foreign_key => "group_id"
  
  belongs_to :group, :class_name => "Group", :foreign_key => "group_id"
  
  def by=(who)
    self.user = who
    return self
  end
  
  def self.NewFromMime(mime)
    mime.strip!
    case mime
      when "application/vnd.ms-office"
        Document.new
      when "application/pdf"
        Document.new
      else
        News.new
    end
  end
  
end

class ShareWithGroup < ActiveRecord::Base
  belongs_to :share
  belongs_to :group
end
