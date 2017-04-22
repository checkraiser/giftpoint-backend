class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def login(session)
  	if valid?
  		command = LoginUser.call(email, password)
  		if command.success?
  			session[:user_id] = command.result.id
  			true
  		else
  			false
  		end
  	end
  end

  def self.check(session)
    self.current_user(session)
  end

  def self.current_user(session)
    return nil unless session[:user_id]
    User.find_by_id(session[:user_id])
  end
end