class HomeController < ApplicationController
  def index
    @timex5_homepage = Page.homepage
    @projects = Project.all_public
  end
end