class CampaignTimeReportQuery < ApplicationQuery
  def initialize
  	@query = SqlQuery.new(:campaign_time_report)
  end
end
