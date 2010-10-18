class AddMoreColumnsToX5ers < ActiveRecord::Migration
  def self.up
    add_column :x5ers, :title, :string
    add_column :x5ers, :sub_text, :text
    add_column :x5ers, :description, :text
    add_column :x5ers, :chinese_description, :text
    add_column :x5ers, :published, :boolean
  end

  def self.down
    remove_column :x5ers, :title
    remove_column :x5ers, :sub_text
    remove_column :x5ers, :description
    remove_column :x5ers, :chinese_description
    remove_column :x5ers, :published
  end
end
