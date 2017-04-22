require 'faker'

100.times do 
  CreateProduct.call(
  	Faker::Commerce.product_name, 
  	Faker::Commerce.promotion_code,
  	Faker::Commerce.price,
  	"kg")
end