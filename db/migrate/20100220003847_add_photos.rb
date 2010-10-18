class AddPhotos < ActiveRecord::Migration
  def self.up
    create_table :photos, :force => true do |t|
      t.integer  :imageable_id
      t.string   :imageable_type
      t.string   :name
      t.text     :description
      t.string   :data_file_name
      t.string   :data_content_type
      t.string   :data_file_size
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :position
    end
  end

  def self.down
    drop_table :photos
  end
end
