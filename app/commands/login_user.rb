class LoginUser < BaseCommand
  prepend SimpleCommand
  
  def initialize(email, password)
  	@email = email
  	@password = password
  end

  def call
  	login_user
  end

  private

  attr_accessor :email, :password

  def login_user
  	user = User.find_by_email(email)
  	return user if user && user.authenticate(password)

  	errors.add :user_authentication, 'invalid credentials'
  	nil
  rescue => e 
    errors.add :login_user, e.message
  end
end