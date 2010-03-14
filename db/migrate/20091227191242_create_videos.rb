class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :url
    end
  end

  def self.down
    drop_table :videos
  end
end
