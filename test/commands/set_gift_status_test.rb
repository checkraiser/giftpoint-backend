require 'test_helper'

class SetGiftStatusTest < ActiveSupport::TestCase
  test "set gift status" do 
  	cc = SetGiftStatus.call(campaign_customer).call 
  	assert cc.result.gift_status, true 
  end
end