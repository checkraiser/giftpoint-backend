class CustomerSearchQuery < ApplicationQuery
  def initialize(campaign_id)
    @query = SqlQuery.new(:customer_search, campaign_id: campaign_id)
  end
end
