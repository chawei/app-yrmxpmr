class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string   :title
      t.text     :sub_text
      t.text     :description
      t.text     :chinese_description
      t.string   :location
      t.boolean  :published
      
      t.string   :video_file_url
      
      t.string   :project_image_file_name
      t.string   :project_image_content_type
      t.integer  :project_image_file_size
      t.datetime :project_image_updated_at
      t.timestamps
    end
    
    create_table :categories_projects, :id => false do |t|
      t.integer :category_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :projects
    drop_table :categories_projects
  end
end
