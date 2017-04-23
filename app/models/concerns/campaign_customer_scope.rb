module CampaignCustomerScope
  extend ActiveSupport::Concern

  included do 
  	scope :generated,   -> { where.not(code: nil) }
  	scope :ungenerated, -> { where(code: nil) }
  	scope :approvable,  -> { generated.unapproved }
  	scope :approved,    -> { where(code_status: true) }
  	scope :unapproved,  -> { where(code_status: false) }
  	scope :generatable, -> { ungenerated.unapproved }
  	scope :cleanable,   -> { unapproved }
  end
end
