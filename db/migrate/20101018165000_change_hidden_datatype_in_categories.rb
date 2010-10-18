class ChangeHiddenDatatypeInCategories < ActiveRecord::Migration
  def self.up
    remove_column :categories, :hidden
    add_column :categories, :hidden, :integer
  end

  def self.down
    remove_column :categories, :hidden
    add_column :categories, :hidden, :boolean
  end
end
