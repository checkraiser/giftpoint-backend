class BatchRecordsSetSmsCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers, records)
  	@campaign_customers = campaign_customers
  	@records = records 
  end

  def call
  	batch_records_set_sms_customers
  end

  private

  attr_accessor :records, :campaign_customers

  def batch_records_set_sms_customers
  	return [] if records.empty?
  	campaign_customers_query = CampaignCustomerQuery.new(campaign_customers)
  	campaign_customers = campaign_customers_query.by_phones(values(records))  	
  	command = BatchSetSmsStatus.call(campaign_customers)
  	return command.result if command.success?
  	prepend_errors command
  rescue => e 
    errors.add :batch_records_set_sms_customers, e.message
  end

  def values(recs)
  	recs.map { |item| item[:phone].to_s }
  rescue => e 
    errors.add :batch_records_set_sms_customers_values, e.message
  end
end
