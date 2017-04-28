module CampaignCustomerAssociation
  extend ActiveSupport::Concern

  included do 
  	belongs_to :campaign
  	belongs_to :customer
  	belongs_to :user, optional: true
  end
end