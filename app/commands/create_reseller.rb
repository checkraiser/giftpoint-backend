class CreateReseller
  include PrependErrors

  def initialize(name, email, password)
    @name = name
  	@email = email
  	@password = password
  end

  def call
  	user
  end

  private

  attr_accessor :name, :email, :password

  def user
  	user = User.reseller.find_by_email(email)
  	return user if user
    user = User.new name: name,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    level: 2
    return user if user.save
  	prepend_errors(user)
  	nil
  end
end