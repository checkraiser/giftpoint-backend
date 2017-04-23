class ApproveCampaignCustomers
  include PrependErrors

  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	approve
  end

  private

  attr_accessor :campaign_customers 

  def approve
  	campaign_customers.approvable.update_all(code_status: true)
  rescue => e 
  	errors.add :approve_campaign_customers, e.message
  end
end
