class CampaignSerializer < ApplicationSerializer
  attributes :id, :name, :content, :start_time, :end_time, :location, :product_count
end
