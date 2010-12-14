class AddFrontpageToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :frontpage, :text
  end

  def self.down
    remove_column :categories, :frontpage
  end
end
