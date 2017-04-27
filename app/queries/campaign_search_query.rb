class CampaignSearchQuery

  def initialize(date, city, product_name)
    @query = SqlQuery.new(:search_campaign, date: date, city: city, product_name: product_name)
  end

  def render
    @query.execute.map(&:symbolize_keys)
  end
end
