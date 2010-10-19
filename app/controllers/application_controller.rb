# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :client_logged_in?, :current_client
  
  before_filter :get_lines
  
  def client_logged_in?
    !!current_client
  end
  
  # Accesses the current client from the session.
  # Future calls avoid the database because nil is not equal to false.
  def current_client
    #@current_client ||= session[:client_id] unless @current_client == false
    @current_client ||= Client.find_by_id session[:client_id]
  end

  # Store the given client id in the session.
  def current_client=(new_client)
    session[:client_id] = new_client ? new_client.id : nil
    @current_client = new_client || false
  end
  
  private 
  
  def get_lines
    @slogan = Line.display("slogan").content
    @tel = Line.display("telephone").content
    @fax = Line.display("fax").content
    @email = Line.display("email").content
  end
end
