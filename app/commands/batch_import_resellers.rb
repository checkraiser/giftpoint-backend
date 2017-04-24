class BatchImportResellers < BaseCommand
  prepend SimpleCommand

  def initialize(records)
  	@records = records
  end

  def call
  	import 
  end

  private

  attr_accessor :records

  def import
  	return [] if records.empty?
  	result = []
  	records.each do |record|
  	  if valid?(record)
	  	command = CreateReseller.call(
	  	  record[:name].to_s, 
	  	  record[:email].to_s, 
	  	  record[:password].to_s, 
	  	  record[:phone].to_s,
	  	  record[:location].to_s
	  	)
	  	if command.success?
	  	  result << command.result 
	  	else
	  	  prepend_errors command
	  	end
	  else
	  	errors.add :batch_import_resellers, "File format is invalid"
	  end
  	end
  	return result
  rescue => e 
  	errors.add :batch_import_resellers, e.message
  end

  def valid?(record)
  	record[:name].present? &&
  	record[:email].present? &&
  	record[:password].present? &&
  	record[:phone].present? &&
  	record[:location].present?
  end
end
