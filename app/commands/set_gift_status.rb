class SetGiftStatus < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customer)
  	@campaign_customer = campaign_customer
  end

  def call
  	set_gift_status
  end

  private

  attr_accessor :campaign_customer

  def set_gift_status
  	campaign_customer.assign_attributes gift_status: true
  	return  campaign_customer if campaign_customer.save
  	prepend_errors(campaign_customer)
  end
end