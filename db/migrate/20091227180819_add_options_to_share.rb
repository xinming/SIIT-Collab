class AddOptionsToShare < ActiveRecord::Migration
  def self.up
    add_column :shares, :options, :text
  end

  def self.down
    remove_column :shares, :options
  end
end
