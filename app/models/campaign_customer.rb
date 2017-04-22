class CampaignCustomer < ApplicationRecord
  belongs_to :campaign
  belongs_to :customer
end
