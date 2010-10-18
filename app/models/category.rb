class Category < ActiveRecord::Base
  acts_as_category
  
  has_and_belongs_to_many :projects
  before_destroy :remove_related_items
  
  named_scope :public_roots, :conditions => {:published => true, :ancestors_count => 0}
  
  def public_children
    children.find_all {|c| c.published == true}
  end
  
  def other_available_categories
    all = Category.all
    self.descendants.each { |d| all.delete(d) }
    all.delete(self)
    all
  end
  
  def toggle_published
    self.published ? self.published = false : self.published = true
  end
  
  def public_projects(current_client=nil)
    if current_client
      return projects.find_all {|p| (p.published == true) or p.clients.include?(current_client) }
    else
      return projects.find_all {|p| p.published == true }
    end
  end
  
  private 
    
    def remove_related_items
      projects.clear
    end
end