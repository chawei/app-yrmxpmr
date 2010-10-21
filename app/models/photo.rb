class Photo < ActiveRecord::Base
  include ValidatesAsImage
  
  default_scope :order => 'position'
  
  belongs_to :imageable, :polymorphic => true
  
  has_attached_file :data, :styles => { :display => "620x620>", 
                                        :thumb => "60x60>" },
                           :storage => :s3, 
                           :s3_credentials => {
                             :access_key_id => S3[:key],
                             :secret_access_key => S3[:secret]
                           },
                           :bucket => S3[:bucket],
                           :path => "/:style/:filename"
                                             
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_as_image :data
end