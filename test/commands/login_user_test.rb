require 'test_helper'

class LoginUserTest < ActiveSupport::TestCase
  test "success login" do 
  	user = CreateAdmin.call("dung", "dungth@hpu.edu.vn", "123123123").result
  	user_login = LoginUser.call(user.email, "123123123").result
  	assert user, user_login
  end

  test "fail login" do 
  	user_login = LoginUser.call("hehe", "123123123")
  	assert user_login.errors, {:user_authentication=>["invalid credentials"]}
  end
end