class CampaignProductsQuery < ApplicationQuery
  def initialize(campaign_name = nil, date1 = nil, date2 = nil)
  	@campaign_name = campaign_name
  	@date1 = date1
  	@date2 = date2
  	@query = SqlQuery.new(:campaign_products, 
  		campaign_name: campaign_name, date1: date1, date2: date2,
  		has_filter: has_filter, has_dates_filter: has_dates_filter,
  		has_campaign_name_filter: has_campaign_name_filter)
  end

  private

  attr_accessor :campaign_name, :date1, :date2

  def has_filter
  	campaign_name.present? || (date1.present? && date2.present?)
  end

  def has_dates_filter
  	date1.present? && date2.present?
  end

  def has_campaign_name_filter
  	campaign_name.present?
  end
end