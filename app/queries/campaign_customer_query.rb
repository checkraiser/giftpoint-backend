class CampaignCustomerQuery
  def initialize(relation = CampaignCustomer.all)
  	@relation = relation
  	self
  end

  def by_phones(phones)
  	customer_ids = Customer.where("phone in (?)", phones)
  	relation.where(customer_id: customer_ids).includes(:customer)
  end

  def by_phone_and_code(phone, code)
  	return nil if phone.nil? or code.nil?
  	phone = phone.to_s
  	customer = Customer.find_by(phone: phone)
  	return nil if customer.nil?
  	code = code.to_s.strip
  	campaign_customer = relation.find_by(customer_id: customer.id, code: code)
  	return campaign_customer
  end

  private

  attr_accessor :relation
end
