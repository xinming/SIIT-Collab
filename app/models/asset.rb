class Asset < ActiveRecord::Base
  belongs_to :attached, :polymorphic => true
  
  has_attached_file :file
end
