require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should get create" do
    login_as_admin    
    assert_response 302
  end

  test "should get destroy" do
    delete logout_url
    assert_response 302
  end

end
