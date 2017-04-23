class CampaignCustomerQuery
  def initialize(relation = CampaignCustomer.all)
  	@relation = relation
  end

  def by_phones(phones)
  	customer_ids = Customer.where("phone in (?)", phones)
  	@relation.where(customer_id: customer_ids).includes(:customer)
  end

  private

  attr_accessor :relation
end
