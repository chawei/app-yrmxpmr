class X5ersController < ApplicationController
  def index
    @x5ers = X5er.all
    @x5ers_homepage = Page.homepage
  end
  
  def show
    @x5er = X5er.find(params[:id])
  end
end