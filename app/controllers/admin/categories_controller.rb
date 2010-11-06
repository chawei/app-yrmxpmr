class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_filter :login_required, :check_access
    
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
    @category.parent_id = params[:parent_id] if params[:parent_id]
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created category."
      redirect_to [:admin, @category]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated category."
      redirect_to [:admin, @category]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    begin
      if @category.destroy
        flash[:notice] = "Successfully destroyed category."
      else
        flash[:notice] = "Not able to remove the category with subcategories."
      end
    rescue
      flash[:notice] = "Not able to remove the category with subcategories."
    end
    redirect_to admin_categories_url
  end
  
  def sort
    params.each_pair do |key, value|
      params[key].each_with_index do |id, index|
        Category.update_all(['position=?', index+1], ['id=?', id])
      end
    end
    render :nothing => true
  end
  
  def toggle_published
    #logger.info "toggle"
    if category = Category.find_by_id(params[:id])
      category.toggle_published
      if category.save
        category.published ? text = "<span class='public'>Public (Set as Private)</span>" \
                           : text = "<span class='private'>Private (Set as Public)</span>"
      else
        text = "Error"
      end
    else
      text = "Category Not Exist"
    end
    render :text => text
  end
  
  private
  
  def check_access
    unless current_user.admin?
      flash[:notice] = "You don't have the access to this page."
      redirect_to admin_projects_path 
    end
  end
end
