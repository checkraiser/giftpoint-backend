class ImportProducts < BaseCommand
  prepend SimpleCommand
  
  def initialize(records)
    @records = records
  end

  def call
  	import_products
  end

  def self.dependencies
    [CreateProduct]
  end

  private

  attr_accessor :records

  def import_products
    return [] if records.empty?
    result = []
    records.each do |record|
      name = record[:name]
      code = record[:code]
      price = record[:price]
      unit = record[:unit]
      command = CreateProduct.call(name, code, price, unit)
      if command.success?
        result << command.result
      end
    end
  	return result
  rescue => e 
    errors.add :import_products, e.message
  end
end