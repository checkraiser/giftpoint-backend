class ImportCustomer
  include PrependErrors

  def initialize(campaign, name, phone)
  	@campaign = campaign
  	@name = name
  	@phone = phone
  end

  def call
  	customer
  end	

  private

  attr_accessor :campaign, :name, :phone

  def customer
    Customer.transaction do 
    	customer = CreateCustomer.call(name, phone)
    	if customer.success?
    	  cc = CreateCampaignCustomer.call campaign, customer.result
  	    return cc.result if cc.success?
        prepend_errors(cc)    
      else
        prepend_errors(customer)    
        raise ActiveRecord::Rollback, "Error"
      end
    end
  end
end