class BatchGenerateCustomerCodes < BaseCommand
  prepend SimpleCommand
    
  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	batch_generate_customer_codes
  end

  def self.dependencies
    [GenerateCustomerCode]
  end

  private

  attr_accessor :campaign_customers

  def batch_generate_customer_codes
  	result = []
  	campaign_customers.generatable.each do |cc|
  	  command = GenerateCustomerCode.call(cc)
  	  if command.success?
  	  	result << command.result
  	  end
  	end
  	return result
  rescue => e 
    errors.add :batch_generate_customer_codes, e.message
  end
end