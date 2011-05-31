# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [ :login, :adminoff, :adminon, :logout ]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  session :session_key => '_myapp_session_id'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # temporary (remove later) 
  def adminoff
    session[:user_id] = false
    redirect_to(jobs_url)
  end
  def adminon
    session[:user_id] = true
     redirect_to(jobs_url)
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin' , :action => 'login'
    end
  end

end
