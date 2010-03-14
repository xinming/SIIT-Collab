class AddGroupToShares < ActiveRecord::Migration
  def self.up
    add_column :shares, :group_id, :integer
  end

  def self.down
    remove_column :shares, :group_id
  end
end
