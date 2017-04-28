class SetGiftStatus < BaseCommand
  prepend SimpleCommand

  def initialize(campaign_customer, reseller)
  	@campaign_customer = campaign_customer
    @reseller = reseller
  end

  def call
  	set_gift_status
  end

  private

  attr_accessor :campaign_customer, :reseller

  def set_gift_status
    errors.add :set_gift_status, "The code is already gifted" unless campaign_customer.giftable?
  	campaign_customer.assign_attributes gift_status: true, user_id: reseller.id
  	return  campaign_customer if campaign_customer.save
  	prepend_errors(campaign_customer)
  rescue => e 
    errors.add :set_gift_status, e.message
  end
end