class CreateProduct
  include PrependErrors

  def initialize(name, code, price, unit)
    @name = name
  	@code = code
    @price = price
    @unit = unit
  end

  def call
  	product
  end

  private

  attr_accessor :name, :code, :price, :unit

  def product
  	product = Product.find_by(code: code)
    return product if product
    product = Product.new name: name,
                          code: code,
                          price: price,
                          unit: unit 
    return product if product.save
  	prepend_errors(product)
  	nil
  end
end