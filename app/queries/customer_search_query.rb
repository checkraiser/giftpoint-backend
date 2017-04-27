class CustomerSearchQuery
  def initialize(campaign_id)
    @query = SqlQuery.new(:customer_search, campaign_id: campaign_id)
  end

  def render
    @query.execute.map(&:symbolize_keys)
  end
end
