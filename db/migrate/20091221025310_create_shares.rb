class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares do |t|
      t.string :type
      t.text :content
      t.references :user
      

      t.timestamps
    end
  end

  def self.down
    drop_table :shares
  end
end
