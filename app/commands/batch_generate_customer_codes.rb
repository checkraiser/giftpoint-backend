class BatchGenerateCustomerCodes
  include PrependErrors
  
  def initialize(campaign)
  	@campaign = campaign
  end

  def call
  	codes
  end

  private

  attr_accessor :campaign

  def codes
  	result = []
  	campaign.campaign_customers.each do |cc|
  	  command = GenerateCustomerCode.call(cc)
  	  if command.success?
  	  	result << command.result
  	  end
  	end
  	return result
  end	
end