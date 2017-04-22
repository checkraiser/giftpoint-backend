class BatchSetSmsStatus
  include PrependErrors

  def initialize(campaign)
  	@campaign = campaign
  end

  def call
  	batch_set_sms_status
  end

  private

  attr_accessor :campaign 

  def batch_set_sms_status
  	result = []
  	campaign.campaign_customers.each do |cc|
  		command = SetSmsStatus.call(cc)
  		if command.success?
  			result << command.result
  		end
  	end
  	return result
  end
end