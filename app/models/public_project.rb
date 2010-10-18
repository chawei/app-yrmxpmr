class PublicProject < ActiveRecord::Base
  default_scope :conditions => ["published=?", true]
end