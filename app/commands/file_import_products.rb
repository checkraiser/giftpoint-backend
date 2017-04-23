class FileImportProducts < BaseCommand
  prepend SimpleCommand
  
  def initialize(file)
  	@file = file
  end

  def call
  	import 
  end

  def self.dependencies
    [FileImport, ImportProducts]
  end

  private

  attr_accessor :file 

  def import
  	command = FileImport.call(file)
  	if command.success?
  		cmd = ImportProducts.call(command.result)
  		return cmd.result if cmd.success?
  		prepend_errors cmd
  	else
  	   prepend_errors command
  	end
  end
end
