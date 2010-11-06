class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :login_required, :check_access
  
  def index
    @pages = Page.custom
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to [:admin, @page]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to [:admin, @page]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to admin_pages_url
  end
  
  private
  
  def check_access
    unless current_user.admin?
      flash[:notice] = "You don't have the access to this page."
      redirect_to admin_projects_path 
    end
  end
end
