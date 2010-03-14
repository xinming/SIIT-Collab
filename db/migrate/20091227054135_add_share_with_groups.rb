class AddShareWithGroups < ActiveRecord::Migration
  def self.up
    create_table :share_with_groups, :id => false, :force => true do |t|
      t.integer :group_id
      t.integer :share_id
    end
  end

  def self.down
    drop_table :share_with_groups, :id => false
  end
end
