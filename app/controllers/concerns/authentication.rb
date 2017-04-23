module Authentication
  extend ActiveSupport::Concern

  included do 
    before_action :require_login
  	helper_method :logged_in?
  	helper_method :current_user
  end

  def require_login
  	unless logged_in?
  		redirect_to login_path, notice: "Please log in"
      return
    end
  end

  def logged_in?
  	!current_user.nil?
  end

  def current_user
  	@current_user ||= Session.current_user(session)
  end
end