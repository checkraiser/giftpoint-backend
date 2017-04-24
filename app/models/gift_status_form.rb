class GiftStatusForm < BaseForm

  attr_accessor :phone, :code

  validates :phone, presence: true
  validates :code, presence: true
  validate :check_code
  

  def save
  	if valid?
  	  command = SetGiftStatus.call(@campaign_customer)
  	  if command.success?
  	  	return command.result
  	  else
  	  	append_errors command
        nil
  	  end
  	end
  end

  private

  def check_code
  	customer = Customer.find_by(phone: phone)
  	errors.add :gift_status_form, "Customer is not found" unless customer
  	if customer
	  @campaign_customer ||= CampaignCustomer.find_by(code: code, customer_id: customer.id)
	  errors.add :gift_status_form, "Code is not found" unless @campaign_customer
	end
  end
end
