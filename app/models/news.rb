class News < ActiveRecord::Base
  has_one :share, :as => :content, :dependent => :destroy
  accepts_nested_attributes_for :share
  
  def name
    "News or Announcement"
  end
end
