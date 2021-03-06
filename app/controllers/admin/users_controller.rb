class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :login_required, :check_access
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/admin/users')
      flash[:notice] = "User successfully created."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id]) 
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to [:admin, @user]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to admin_users_url
  end
  
  private
  
  def check_access
    unless current_user.admin?
      flash[:notice] = "You don't have the access to this page."
      redirect_to admin_projects_path 
    end
  end
end
