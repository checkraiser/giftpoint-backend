class BatchSetSmsStatus < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	batch_set_sms_status
  end

  def self.dependencies
    [SetSmsStatus]
  end

  private

  attr_accessor :campaign_customers 

  def batch_set_sms_status
  	result = []
  	campaign_customers.smsable.each do |cc|
  		command = SetSmsStatus.call(cc)
  		if command.success?
  			result << command.result
  		end
  	end
  	return result
  rescue => e 
    errors.add :batch_set_sms_status, e.message
  end
end