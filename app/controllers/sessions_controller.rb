# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem

  # render new.rhtml
  def new
  end
  
  def show
    redirect_to home_path
  end

  def create
    #logout_keeping_session!
    client = Client.authenticate(params[:login], params[:password])
    if client
      # Protects against session fixation attacks, causes request forgery
      # protection if client resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_client = client
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if request.xhr?
        render :text => (session[:return_to] ||= '/')
      else
        redirect_back_or_default('/')
        flash[:notice] = "Logged in successfully"
      end
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      if request.xhr?
        render :text => 'Wrong username/password'
      else
        flash[:notice] = "Login error"
        redirect_to home_path
      end
    end
  end

  def destroy
    #logout_killing_session!
    session[:client_id] = nil
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
