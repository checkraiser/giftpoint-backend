module Authentication
  extend ActiveSupport::Concern

  included do 
  	helper_method :logged_in?
  	helper_method :current_user
  end

  def require_login
  	if !Session.check(session)
  		redirect_to login_path and return
  	end
  end

  def logged_in?
  	Session.check(session)
  end

  def current_user
  	@current_user ||= Session.current_user(session)
  end
end