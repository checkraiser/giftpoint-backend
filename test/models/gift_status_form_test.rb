require 'test_helper'

class GiftStatusFormTest < ActiveSupport::TestCase
  test "success" do 
    campaign_customer = approved_campaign_customer
    gf = GiftStatusForm.new(code: campaign_customer.code, phone: campaign_customer.customer.phone)
    gf.save
    assert campaign_customer.reload.gift_status, true
  end
end
