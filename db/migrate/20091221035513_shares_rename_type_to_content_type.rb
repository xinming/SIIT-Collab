class SharesRenameTypeToContentType < ActiveRecord::Migration
  def self.up
    rename_column :shares, :type, :content_type
  end

  def self.down
    rename_column :shares, :content_type, :type
  end
end
