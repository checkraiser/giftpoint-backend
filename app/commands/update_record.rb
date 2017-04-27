class UpdateRecord < BaseCommand
  prepend SimpleCommand

  def initialize(record, record_params)
  	@record = record
  	@record_params = record_params
  end

  def call
  	update_record
  end

  private

  attr_accessor :record, :record_params

  def update_record
  	record.assign_attributes record_params
  	if record.save
  	  return record
  	else
  	  prepend_errors record
  	end
  rescue => e 
  	errors.add :update_record, e.message
  end
end
