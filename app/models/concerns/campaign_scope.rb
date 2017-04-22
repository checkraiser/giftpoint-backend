module CampaignScope
  extend ActiveSupport::Concern

  included do 
  	scope :available, -> { where("? BETWEEN start_time AND end_time", Time.current) }
  end
end