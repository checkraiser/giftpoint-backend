class BatchFileSetSmsCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers, file)
  	@campaign_customers = campaign_customers
  	@file = file 
  end

  def call
  	batch_file_set_sms_customers
  end

  private

  attr_accessor :file, :campaign_customers
	
  def batch_file_set_sms_customers
  	command = FileImport.call(file)
  	if command.success?
  		cmd = BatchRecordsSetSmsCustomers.call(campaign_customers, command.result)
  		return cmd if cmd.success?
  		prepend_errors cmd.errors
  	else
  		prepend_errors command.errors
  	end
  rescue => e 
    errors.add :batch_file_set_sms_customers, e.message
  end
end
