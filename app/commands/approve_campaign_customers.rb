class ApproveCampaignCustomers
  include PrependErrors

  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	approve
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :campaign_customers 

  def approve
  	campaign_customers.approve_all
  rescue => e 
  	errors.add :approve_campaign_customers, e.message
  end
end
