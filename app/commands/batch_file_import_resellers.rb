class BatchFileImportResellers < BaseCommand
  prepend SimpleCommand

  def initialize(resellers_file)
  	@resellers_file = resellers_file
  end

  def call
  	batch_file_import_resellers 
  end

  private

  attr_accessor :resellers_file

  def batch_file_import_resellers
  	if resellers_file.nil?
  	  errors.add :batch_file_import_resellers, "File is empty"
  	  return []
  	end
  	records_command = FileImport.call(resellers_file)
  	if records_command.success?
      import_command = BatchImportResellers.call(records_command.result)
      if import_command.success?
      	return import_command.result
      else
      	prepend_errors import_command
      end
  	else
  	  prepend_errors records_command
  	end
  rescue => e 
  	errors.add :batch_file_import_resellers, e.message
  end
end