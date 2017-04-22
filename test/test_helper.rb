ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start

module CampaignHelper
  def campaign
  	@campaign ||= CreateCampaign.call("campaign 1", "content", time, time + 1.month, "Hai Phong", 10).result
  end

  def campaign_customer
  	@campaign_customer ||= ImportCustomer.call(campaign, "customer 1", "01214115322").result
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
