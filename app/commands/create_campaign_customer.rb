class CreateCampaignCustomer < BaseCommand
  prepend SimpleCommand
  
  def initialize(campaign, customer)
  	@campaign = campaign
  	@customer = customer
  end

  def call
  	campaign_customer
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :campaign, :customer

  def campaign_customer
  	cc = CampaignCustomer.new campaign: campaign,
  							              customer: customer
  	return cc if cc.save
  	prepend_errors cc
  rescue => e 
    errors.add :create_campaign_customer, e.message
  end
end