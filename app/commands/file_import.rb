class FileImport < BaseCommand
  prepend SimpleCommand
  
  def initialize(file)
  	@file = file
  end

  def call
  	file_import 
  end

  def self.dependencies
    []
  end
  
  private

  attr_accessor :file 

  def file_import
  	result = []
  	spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose].deep_symbolize_keys
      result << row 
    end
  	return result
  rescue => e 
  	errors.add :file_import, e.message
  end

  def open_spreadsheet(file)
  	Roo::Spreadsheet.open(file.path, extension: :xlsx)
  rescue => e 
    errors.add :file_import_open_spreadsheet, e.message
  end
end