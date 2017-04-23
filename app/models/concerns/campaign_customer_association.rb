module CampaignCustomerAssociation
  extend ActiveSupport::Concern

  included do 
  	belongs_to :campaign
  	belongs_to :customer
  end
end