class BatchImportCustomers
  include PrependErrors

  def initialize(campaign, customer_records)
  	@campaign = campaign
  	@customer_records = customer_records
  end

  def call
  	customers
  end

  private

  attr_accessor :campaign, :customer_records

  def customers
  	result = []
  	return [] if customer_records.empty?
  	customer_records.each do |record|
  	  name = record[:name]
  	  phone = record[:phone]
  	  if name && phone
  	  	ic = ImportCustomer.call(campaign, name, phone)
  	  	result << ic.result if ic.success?
  	  end
  	end
  	return result
  end
end