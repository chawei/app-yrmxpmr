class X5er < ActiveRecord::Base
  has_and_belongs_to_many :projects
  before_destroy :remove_related_items
  
  has_many :photos, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :photos
  
  def public_projects(current_client=nil)
    if current_client
      return projects.find_all {|p| (p.published == true) or p.clients.include?(current_client) }
    else
      return projects.find_all {|p| p.published == true }
    end
  end
  
  def has_chinese_description?
    return (chinese_description and !chinese_description.gsub(/<\/?[^>]*>/, "").blank?)
  end
  
  private
    def remove_related_items
      projects.clear
    end
end