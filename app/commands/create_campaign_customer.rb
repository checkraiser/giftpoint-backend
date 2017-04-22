class CreateCampaignCustomer
  include PrependErrors

  def initialize(campaign, customer)
  	@campaign = campaign
  	@customer = customer
  end

  def call
  	campaign_customer
  end

  private

  attr_accessor :campaign, :customer

  def campaign_customer
  	cc = CampaignCustomer.find_by(campaign_id: campaign.id, customer_id: customer.id)
  	return cc if cc 
  	cc = CampaignCustomer.new campaign: campaign,
  							  customer: customer
  	return cc if cc.save
  	prepend_errors cc
  end
end