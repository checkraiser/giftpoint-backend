class CreateAdmin
  include PrependErrors

  def initialize(name, email, password)
    @name = name
  	@email = email
  	@password = password
  end

  def call
  	user
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :name, :email, :password

  def user
  	user = User.admin.find_by_email(email)
    if user
  	  errors.add :create_admin, "Admin exists" 
      return nil
    end
    user = User.new name: name,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    level: 1
    return user if user.save
    prepend_errors(user)
  	nil
  end
end