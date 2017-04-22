module CampaignAssociation
  extend ActiveSupport::Concern

  included do 
  	has_many :campaign_customers
  	has_many :customers, through: :campaign_customer
  	belongs_to :product
  end
end