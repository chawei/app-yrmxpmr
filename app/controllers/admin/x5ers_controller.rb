class Admin::X5ersController < ApplicationController
  layout 'admin'
  before_filter :login_required
  
  def index
    @x5ers = X5er.all
  end
  
  def show
    @x5er = X5er.find(params[:id])
  end
  
  def new
    @x5er = X5er.new
  end
  
  def create
    @x5er = X5er.new(params[:x5er])
    if @x5er.save
      flash[:notice] = "Successfully created x5er."
      redirect_to [:admin, @x5er]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @x5er = X5er.find(params[:id])
  end
  
  def update
    @x5er = X5er.find(params[:id])
    if @x5er.update_attributes(params[:x5er])
      flash[:notice] = "Successfully updated x5er."
      redirect_to [:admin, @x5er]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @x5er = X5er.find(params[:id])
    @x5er.destroy
    flash[:notice] = "Successfully destroyed x5er."
    redirect_to admin_x5ers_url
  end

end