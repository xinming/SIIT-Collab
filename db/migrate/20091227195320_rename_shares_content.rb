class RenameSharesContent < ActiveRecord::Migration
  def self.up
    rename_column :shares, :content, :content_id
  end

  def self.down
    rename_column :shares, :content_id, :content
  end
end
