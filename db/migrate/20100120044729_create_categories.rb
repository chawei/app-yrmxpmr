class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      # Needed by acts_as_category
      t.integer :parent_id, :children_count, :ancestors_count, :descendants_count
      t.boolean :hidden
              
      t.string :name, :short_name
      t.boolean :published
      t.integer :position
    end
  end

  def self.down
    drop_table :categories
  end
end
