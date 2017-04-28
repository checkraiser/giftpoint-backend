require 'test_helper'

class FavoriteProductsQueryTest < ActiveSupport::TestCase
  test "correct" do 
  	campaign_customers
  	query = FavoriteProductsQuery.new
  	assert query.render, [{:product_name=>"product 1", :product_count=>2}]
  end
end