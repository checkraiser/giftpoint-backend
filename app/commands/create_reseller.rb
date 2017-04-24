class CreateReseller < BaseCommand
  prepend SimpleCommand
  
  def initialize(name, email, password, phone = nil, location = nil)
    @name = name
  	@email = email
  	@password = password
    @phone = phone
    @location = location
  end

  def call
  	user
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :name, :email, :password, :phone, :location

  def user
  	user = User.reseller.find_by_email(email)
  	return user if user
    user = User.new name: name,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    level: 2,
                    phone: phone,
                    location: location
    return user if user.save
  	prepend_errors(user)
  	nil
  rescue => e 
    errors.add :create_reseller, e.message
  end
end