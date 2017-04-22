require 'test_helper'

class CreateProductTest < ActiveSupport::TestCase
  test "success create" do 
  	cc = CreateProduct.call("p1", "c1", 123, "kg")
  	assert Product.all, [cc.result]
  end

  test "fail create" do 
  	cc = CreateProduct.call("", "c1", "fds", "kg")
  	assert cc.errors, {:name=>["can't be blank"], :price=>["is not a number"]}
  end
end