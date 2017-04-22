class ImportProducts
  include PrependErrors

  def initialize(records)
    @records = records
  end

  def call
  	products
  end

  private

  attr_accessor :records

  def products
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
  end
end