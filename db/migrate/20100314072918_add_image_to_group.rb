class AddImageToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :image_uid, :string
  end

  def self.down
    remove_column :groups, :image_uid
  end
end
