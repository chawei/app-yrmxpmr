class CreateLines < ActiveRecord::Migration
  def self.up
    create_table :lines, :force => true do |t|
      t.string :unique_name
      t.string :name
      t.string :data_type
      t.text   :content
      t.timestamps
    end
  end

  def self.down
    drop_table :lines
  end
end