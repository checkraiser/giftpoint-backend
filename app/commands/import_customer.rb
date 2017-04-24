class ImportCustomer < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign, name, phone)
  	@campaign = campaign
  	@name = name
  	@phone = phone
  end

  def call
  	import_customer
  end	

  def self.dependencies
    [CreateCustomer, CreateCampaignCustomer]
  end

  private

  attr_accessor :campaign, :name, :phone

  def import_customer
    transaction do 
    	customer = CreateCustomer.call(name, phone)
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