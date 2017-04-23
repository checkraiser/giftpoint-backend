class CleanCampaignCustomers
  include PrependErrors

  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	clean 
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :campaign_customers 

  def clean
  	campaign_customers.clean
  end
end