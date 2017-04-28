class ImportCustomer < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign, name, phone, city = nil, address = nil)
  	@campaign = campaign
  	@name = name
  	@phone = phone
    @city = city
    @address = address
  end

  def call
  	import_customer
  end	

  def self.dependencies
    [CreateCustomer, CreateCampaignCustomer]
  end

  private

  attr_accessor :campaign, :name, :phone, :city, :address

  def import_customer
    transaction do 
    	customer = CreateCustomer.call(name, phone, city, address)
    	if customer.success?
    	  cc = CreateCampaignCustomer.call campaign, customer.result
  	    return cc.result if cc.success?
        prepend_errors(cc)    
        rollback "Error"
      else
        prepend_errors(customer)    
      end
    end
  rescue => e 
    errors.add :import_customer, e.message
  end
end