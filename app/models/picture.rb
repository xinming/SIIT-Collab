class Picture < ActiveRecord::Base
  has_one :share, :as => :content, :dependent => :destroy
  accepts_nested_attributes_for :share
  
  image_accessor :image
  def name
    "Picture"
  end
end
