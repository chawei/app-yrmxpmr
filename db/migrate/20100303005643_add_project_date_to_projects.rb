class AddProjectDateToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :project_date, :date, :default => Date.today
  end

  def self.down
    remove_column :projects, :project_date
  end
end
