class Admin::ProjectsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  
  def index
    if current_user.admin?
      @projects = Project.paginate :page => params[:page], :per_page => 10
    else
      @projects = current_user.projects.paginate :page => params[:page], :per_page => 10
    end
  end
  
  def show
    @project = Project.find(params[:id])
    unless current_user.admin? or current_user.projects.include?(@project)
      flash[:notice] = "You don't have the access to this project."
      redirect_to :action => "index"
    end
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      @project.users << current_user
      flash[:notice] = "Successfully created project."
      redirect_to [:admin, @project]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to [:admin, @project]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to admin_projects_url
  end
  
  def sort
    params["projects"].each_with_index do |id, index|
      Project.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def toggle_published
    if project = Project.find_by_id(params[:id])
      project.toggle_published
      if project.save
        project.published ? text = "<span class='public'>Public (Set as Private)</span>" \
                          : text = "<span class='private'>Private (Set as Public)</span>"
      else
        text = "Error"
      end
    else
      text = "Project Not Exist"
    end
    render :text => text
  end
  
  def delete_photo
    photo = Photo.find(params[:photo_id])
    photo.destroy
    if request.xhr?
      render :nothing => true
    end
  end
end
