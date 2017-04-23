class BatchImportCustomers < BaseCommand
  
  def initialize(campaign, customer_records)
  	@campaign = campaign
  	@customer_records = customer_records
  end

  def call
  	customers
  end

  def self.dependencies
    [ImportCustomer]
  end

  private

  attr_accessor :campaign, :customer_records

  def customers
  	result = []
  	return [] if customer_records.empty?
  	customer_records.each do |record|
  	  name = record[:name].to_s
  	  phone = record[:phone].to_s
      gen_count = record[:gen_count].to_i
  	  if gen_count > 0
        gen_count.times do 
  	  	  ic = ImportCustomer.call(campaign, name, phone)
  	  	  result << ic.result if ic.success?
        end
  	  end
  	end
  	return result
  end
end