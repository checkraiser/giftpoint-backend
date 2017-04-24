require 'test_helper'

class GiftStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gift_statuses_index_url
    assert_response :success
  end

  test "should get create" do
    get gift_statuses_create_url
    assert_response :success
  end

end
