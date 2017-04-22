class SetSmsStatus
  include PrependErrors

  def initialize(campaign_customer)
  	@campaign_customer = campaign_customer
  end

  def call
  	set_sms_status
  end

  private

  attr_accessor :campaign_customer

  def set_sms_status
  	campaign_customer.assign_attributes sms_status: true
  	return campaign_customer if campaign_customer.save
  	prepend_errors(campaign_customer)
  end
end