ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start
class ActiveSupport::TestCase
  setup do
  	DatabaseCleaner.clean
  end
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  def time
  	Time.current
  end

  def campaign
  	@campaign ||= CreateCampaign.call("campaign 1", "content", time, time + 1.month, "Hai Phong", 10).result
  end

  def campaign_customer
  	@campaign_customer ||= ImportCustomer.call(campaign, "customer 1", "01214115322").result
  end
  # Add more helper methods to be used by all tests here...
end
