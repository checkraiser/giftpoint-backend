class CreateAdmin < BaseCommand
  prepend SimpleCommand
  
  def initialize(name, email, password)
    @name = name
  	@email = email
  	@password = password
  end

  def call
  	create_admin
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :name, :email, :password

  def create_admin
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
  rescue => e 
    errors.add :create_admin, e.message
  end
end