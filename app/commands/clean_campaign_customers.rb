class CleanCampaignCustomers < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign_customers)
  	@campaign_customers = campaign_customers
  end

  def call
  	clean_campaign_customers 
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :campaign_customers 

  def clean_campaign_customers
  	campaign_customers.clean
  rescue => e 
    errors.add :clean_campaign_customers, e.message
  end
end