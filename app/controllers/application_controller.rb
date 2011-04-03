# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  session :session_key => '_myapp_session_id'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def adminoff
    session[:admin_id] = false
    redirect_to(jobs_url)
  end

  def adminon
    session[:admin_id] = true
     redirect_to(jobs_url)
  end

end
