class BatchGenerateCustomerCodes < BaseCommand
    
  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	codes
  end

  def self.dependencies
    [GenerateCustomerCode]
  end

  private

  attr_accessor :campaign_customers

  def codes
  	result = []
  	campaign_customers.generatable.each do |cc|
  	  command = GenerateCustomerCode.call(cc)
  	  if command.success?
  	  	result << command.result
  	  end
  	end
  	return result
  end	
end