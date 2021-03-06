ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start

module CampaignHelper
  def reseller
    @reseller ||= CreateReseller.call("Reseller", "reseller@gmail.com", "123123123").result
  end

  def campaign
  	@campaign ||= CreateCampaign.call("campaign 1", "content", time, time + 1.month, "Hai Phong", 10, product).result
  end

  def campaigns
    @campaigns ||= [
      CreateCampaign.call("campaign 1", "content 1", time, time + 1.month, "Hai Phong 1", 10, product).result,
      CreateCampaign.call("campaign 2", "content 2", time, time + 1.month, "Hai Phong 2", 10, product).result
    ]
  end

  def campaign_customers
    return @campaign_customers if @campaign_customers
    ImportCustomer.call(campaign, "customer 1", "01214115322", "hehe", "abc")
    ImportCustomer.call(campaign, "customer 2", "01214115323", "hehe", "abc")
    @campaign_customers = CampaignCustomer.all
  end

  def approved_campaign_customers
    return @campaign_customers if @campaign_customers
    ImportCustomer.call(campaign, "customer 1", "01214115322", "hehe", "abc")
    ImportCustomer.call(campaign, "customer 2", "01214115323", "hehe", "abc")    
    BatchGenerateCustomerCodes.call CampaignCustomer.all
    ApproveCampaignCustomers.call(CampaignCustomer.all)
    @campaign_customers = CampaignCustomer.approved
  end

  def campaign_customer
  	@campaign_customer ||= ImportCustomer.call(campaign, "customer 1", "01214115322", "hehe", "abc").result
  end

  def product
    @product ||= CreateProduct.call("product 1", "code product 1", 10, "kg").result
  end

  def customers_file
    @customer_file ||= File.open("#{Rails.root}/test/fixtures/files/customers.xls")
  end

  def resellers_file
    @resellers_file ||= File.open("#{Rails.root}/test/fixtures/files/resellers.xlsx")
  end

  def customers_sms_file
    @customers_sms_file ||= File.open("#{Rails.root}/test/fixtures/files/customers_sms.xlsx")
  end

  def approved_campaign_customer
    @campaign_customer ||= approved_campaign_customers.first
  end
end

class ActiveSupport::TestCase
  include CampaignHelper
  setup do
  	DatabaseCleaner.clean
  end
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  def time
  	Time.current
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  setup do
  	DatabaseCleaner.clean
  end

  def login_as_admin
    CreateAdmin.call("Dung", "dungth@hpu.edu.vn", "123123123")
    post login_url, params: { session: { email: "dungth@hpu.edu.vn", password: "123123123"} }
  end
end
