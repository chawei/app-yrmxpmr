class AddX5ers < ActiveRecord::Migration
  def self.up
    create_table :x5ers do |t|
      t.string :name
      t.string :email
    end
    
    create_table :projects_x5ers, :id => false do |t|
      t.integer :project_id
      t.integer :x5er_id
    end
  end

  def self.down
    drop_table :x5ers
    drop_table :projects_x5ers
  end
end
