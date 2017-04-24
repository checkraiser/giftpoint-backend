class CreateProduct < BaseCommand
  prepend SimpleCommand
  
  def initialize(name, code, price, unit)
    @name = name
  	@code = code
    @price = price
    @unit = unit
  end

  def call
  	create_product
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :name, :code, :price, :unit

  def create_product
  	product = Product.find_by(code: code)
    return product if product
    product = Product.new name: name,
                          code: code,
                          price: price,
                          unit: unit 
    return product if product.save
  	prepend_errors(product)
  	nil
  rescue => e 
    errors.add :create_product, e.message
  end
end