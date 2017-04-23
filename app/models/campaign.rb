class Campaign < ApplicationRecord
  include CampaignValidator, 
  		  CampaignAssociation, 
  		  CampaignScope
end
