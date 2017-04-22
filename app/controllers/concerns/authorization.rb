module Authorization
  extend ActiveSupport::Concern

  def require_admin
  	require_login
  	unless current_user.admin?
  	  redirect_to root_path, error: "You're not authorized to do this"
  	end
  end

  def require_reseller
  	require_login

  	unless current_user.acts_as_reseller?
  	  redirect_to root_path, error: "You're not authorized to do this"
  	end
  end
end