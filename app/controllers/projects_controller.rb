class ProjectsController < ApplicationController
  def index
    options = {
      :order => 'title DESC',
    }
    
    if params[:term]
      options[:include] = ["categories"]
      options[:conditions] = [
        "categories.name LIKE :term OR title LIKE :term OR sub_text LIKE :term OR description LIKE :term OR chinese_description LIKE :term",
        {:term => "%#{params[:term]}%"}
      ]
    end
    projects = Project.find(:all, options)
    @projects = projects.find_all {|p| (p.published == true) or p.clients.include?(current_client) }
  end
  
  def show
    @project = Project.find(params[:id])
    if request.xhr?
      render :template => 'projects/ajax_show', :layout => false
    end
  end
end