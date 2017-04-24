class CreateCustomer < BaseCommand
  prepend SimpleCommand
  
  def initialize(name, phone)
    @name = name
  	@phone = phone
  end

  def call
  	create_customer
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :name, :phone

  def create_customer
  	customer = Customer.find_by(phone: phone)
    return customer if customer
    customer = Customer.new name: name,
                            phone: phone
    return customer if customer.save
  	prepend_errors(customer)
  	nil
  rescue => e 
    errors.add :create_customer, e.message
  end
end