class ChangeNameInPresentation < ActiveRecord::Migration
  def self.up
    rename_column :presentations, :name, :title
    rename_column :presentations, :description, :body
  end

  def self.down
    rename_column :presentations, :title, :name
    rename_column :presentations, :body, :description
  end
end
