class CampaignSearchQuery < ApplicationQuery
  def initialize(date, city, product_name)
    @query = SqlQuery.new(:search_campaign, date: date, city: city, product_name: product_name)
  end
end
