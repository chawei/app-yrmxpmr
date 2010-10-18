class Page < ActiveRecord::Base
  def self.custom
    [self.homepage]
  end
  
  def self.homepage
    pages = Page.find(:all, :conditions => ['unique_name=?', 'homepage'])
    if pages.blank?
      page = Page.create(:unique_name => 'homepage',
                         :name => 'Homepage',
                         :content => 'Please edit me')
    else
      page = pages[0]
    end
    return page
  end
  
  def self.timex5_home
    pages = Page.find(:all, :conditions => ['unique_name=?', 'timex5_home'])
    if pages.blank?
      page = Page.create(:unique_name => 'timex5_home',
                         :name => 'timex5 top page',
                         :content => 'Please edit me')
    else
      page = pages[0]
    end
    return page
  end
end