class BatchRecordsSetSmsCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers, records)
  	@campaign_customers = campaign_customers
  	@records = records 
  end

  def call
  	set_sms
  end

  private

  attr_accessor :records, :campaign_customers

  def set_sms
  	return [] if records.empty?
  	campaign_customers_query = CampaignCustomerQuery.new(campaign_customers)
  	campaign_customers = campaign_customers_query.by_phones(values(records))  	
  	command = BatchSetSmsStatus.call(campaign_customers)
  	return command.result if command.success?
  	prepend_errors command
  end

  def values(recs)
  	recs.map { |item| item[:phone].to_s }
  end
end
