module CampaignValidator
  extend ActiveSupport::Concern

  included do 
  	validates :name, presence: true
  	validates_datetime :end_time, :after => :start_time
  	validates :product_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  	validates :product, presence: true
  end
end
