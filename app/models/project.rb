class Project < ActiveRecord::Base
  include ValidatesAsImage
  
  default_scope :order => 'project_date DESC'
  
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :x5ers
  has_and_belongs_to_many :clients
  
  has_many :photos, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :photos
  
  has_attached_file :project_image, 
                    :styles => { :thumb => "60x60>",
                                 :display => "620x400" },
                    :storage => :s3, 
                    :s3_credentials => {
                      :access_key_id => S3[:key],
                      :secret_access_key => S3[:secret]
                    },
                    :bucket => S3[:bucket],
                    :path => "/:style/:filename"
                    
  validates_attachment_size :project_image, :less_than => 1.megabytes, 
                                            :if => Proc.new { |imports| !imports.project_image_file_name.blank? }
  validates_as_image        :project_image
  
  before_destroy :remove_related_items
  
  def toggle_published
    self.published ? self.published = false : self.published = true
  end
  
  def has_chinese_description?
    return (chinese_description and !chinese_description.gsub(/<\/?[^>]*>/, "").blank?)
  end
  
  def parent_category
    return categories.find_all { |c| c.descendants_count == 0 }[0]
  end
  
  def root_parent_category
    return parent_category.root
  end
  
  def self.all_public
    self.all.find_all {|p| p.published == true }
  end
  
  def self.all_private
    self.all.find_all {|p| p.published != true }
  end
  
  private
  
    def remove_related_items
      categories.clear
      x5ers.clear
      clients.clear
    end
    
end