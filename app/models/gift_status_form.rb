class GiftStatusForm < BaseForm

  attr_accessor :phone, :code

  validates :phone, presence: true
  validates :code, presence: true
  validate :check_code
  

  def find 
    result = CampaignCustomerQuery.new.by_phone_and_code(phone, code)
    return result if result
    errors.add :gift_status_form, "No result"
    nil
  end
end
