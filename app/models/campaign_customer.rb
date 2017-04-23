class CampaignCustomer < ApplicationRecord
  include CampaignCustomerAssociation, 
  		  CampaignCustomerValidator, 
  		  CampaignCustomerScope
end
