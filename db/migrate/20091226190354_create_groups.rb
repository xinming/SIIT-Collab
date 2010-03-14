class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.text :options
      t.references :creator
      
      t.timestamps
    end
    
    create_table :memberships, :id => false, :force => true do |t|
      t.references :group
      t.references :user
    end
  end

  def self.down
    drop_table :groups
    drop_table :memberships
  end
end
