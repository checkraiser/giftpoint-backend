class FileImport < BaseCommand
  prepend SimpleCommand
  
  def initialize(file)
  	@file = file
  end

  def call
  	import 
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :file 

  def import
  	result = []
  	spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose].deep_symbolize_keys
      result << row 
    end
  	return result
  rescue => e 
  	errors.add :file_import_customers, e.message
  end

  def open_spreadsheet(file)
  	Roo::Spreadsheet.open(file.path, extension: :xlsx)
  end
end