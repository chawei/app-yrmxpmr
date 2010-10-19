class Line < ActiveRecord::Base
  def self.custom
    [self.display('slogan', 'text'), self.display('telephone'), 
     self.display('fax'), self.display('email')]
  end
  
  def self.display(name, data_type='string')
    unless line = Line.find_by_unique_name(name)
      line = Line.create(:unique_name => name.downcase,
                         :name => name.capitalize,
                         :data_type => data_type,
                         :content => 'Please edit me')
    end
    return line
  end
end