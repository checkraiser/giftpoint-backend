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
    scope :exportable,  -> { approved }
    scope :smsable,     -> { approved }
    scope :giftable,    -> { approved.not.gifted }
    scope :gifted,      -> { where(gift_status: true) }
  end

  def gifted?
    gift_status == true
  end

  def giftable?
    smsed? && !gifted?
  end

  def smsed?
    sms_status == true
  end

  class_methods do 
    def approve_all
      approvable.update_all(code_status: true)
    end

    def clean 
      cleanable.delete_all
    end
  end
end
