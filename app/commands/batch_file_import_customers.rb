class BatchFileImportCustomers
  include PrependErrors

  def initialize(campaign, file)
  	@campaign = campaign
  	@file = file
  end

  def call
  	import
  end

  private

  attr_accessor :campaign, :file 

  def import
  	command = FileImport.call(file)
  	if command.success?
  		cmd = BatchImportCustomers.call(campaign, command.result)
  		return cmd.result if cmd.success?
  		prepend_errors cmd
  	else
  	   prepend_errors command
  	end
  end
end