module Authorization
  extend ActiveSupport::Concern

  included do 
    helper_method :admin?
    helper_method :reseller?
  end

  def require_admin
  	unless current_user.admin?
  	  redirect_to root_path, danger: "You're not authorized to do this"
  	end
  end

  def require_reseller
  	unless current_user.acts_as_reseller?
  	  redirect_to root_path, danger: "You're not authorized to do this"
  	end
  end

  def admin?
    current_user && current_user.admin?
  end

  def reseller?
    current_user && current_user.reseller?
  end
end