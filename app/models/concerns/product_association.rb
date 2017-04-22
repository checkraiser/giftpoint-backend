module ProductAssociation
  extend ActiveSupport::Concern

  included do 
  	has_many :campaigns
  end
end