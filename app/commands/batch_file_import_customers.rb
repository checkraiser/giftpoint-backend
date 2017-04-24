class BatchFileImportCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign, file)
  	@campaign = campaign
  	@file = file
  end

  def call
  	batch_file_import_customers
  end

  def self.dependencies
    [FileImport, CleanCampaignCustomers, BatchImportCustomers]
  end
  private

  attr_accessor :campaign, :file 

  def batch_file_import_customers
  	command = FileImport.call(file)
  	if command.success?
      CleanCampaignCustomers.call(campaign.campaign_customers)
  		cmd = BatchImportCustomers.call(campaign, command.result)
  		return cmd.result if cmd.success?
  		prepend_errors cmd
  	else
  	   prepend_errors command
  	end
  rescue => e 
    errors.add :batch_file_import_customers, e.message
  end
end