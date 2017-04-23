class BatchFileSetSmsCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers, file)
  	@campaign_customers = campaign_customers
  	@file = file 
  end

  def call
  	file_set_sms
  end

  private

  attr_accessor :file, :campaign_customers
	
  def file_set_sms
  	command = FileImport.call(file)
  	if command.success?
  		cmd = BatchRecordsSetSmsCustomers.call(campaign_customers, command.result)
  		return cmd if cmd.success?
  		prepend_errors cmd.errors
  	else
  		prepend_errors command.errors
  	end
  end  
end
