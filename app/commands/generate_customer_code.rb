class GenerateCustomerCode < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customer)
  	@campaign_customer = campaign_customer  	
  end

  def call
  	code
  end

  private

  attr_accessor :campaign_customer

  def code
  	if !campaign_customer.campaign || !campaign_customer.customer 
  	  return ""
  	else
  	  code = CouponCode.generate(parts: 3)
  	  campaign_customer_code = "#{code}"
  	  campaign_customer.assign_attributes code: campaign_customer_code
  	  return campaign_customer if campaign_customer.save
  	  prepend_errors(campaign_customer)
  	end
  end
end