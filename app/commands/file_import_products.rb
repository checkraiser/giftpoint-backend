class FileImportProducts < BaseCommand
  prepend SimpleCommand
  
  def initialize(file)
  	@file = file
  end

  def call
  	file_import_products 
  end

  def self.dependencies
    [FileImport, ImportProducts]
  end

  private

  attr_accessor :file 

  def file_import_products
  	command = FileImport.call(file)
  	if command.success?
  		cmd = ImportProducts.call(command.result)
  		return cmd.result if cmd.success?
  		prepend_errors cmd
  	else
  	   prepend_errors command
  	end
  rescue => e 
    errors.add :file_import_products, e.message
  end
end
