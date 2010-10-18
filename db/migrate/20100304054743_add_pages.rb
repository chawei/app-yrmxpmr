class AddPages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :unique_name
      t.string :name
      t.text :content
    end    
  end

  def self.down
    drop_table :pages    
  end
end

