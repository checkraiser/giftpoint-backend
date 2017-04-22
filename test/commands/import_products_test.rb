require 'test_helper'

class ImportProductsTest < ActiveSupport::TestCase
  test "success import" do 
  	records = [{name: "p1", code: "c1", price: 12, unit: "kg"}, {name: "p2", code: "c2", price: 12, unit: "kg"}]
  	cc = ImportProducts.call(records)
  	assert Product.all, cc.result
  end

  test "partially failed import" do 
  	records = [{name: "p1", code: "c1", price: 12, unit: "kg"}, {name: "p2", code: "c1", price: 12, unit: "kg"}]
  	cc = ImportProducts.call(records)
  	assert Product.all, cc.result
  	assert Product.count, 1
  end
end