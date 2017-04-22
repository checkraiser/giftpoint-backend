require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create admin" do 
  	admin = CreateAdmin.call("Dung", "dungth@hpu.edu.vn", "123123123")
  	assert User.admin, [admin]
  end

  test "fail create admin" do 
    admin = CreateAdmin.call("", "dungth@hpu.edu.vn", "123123123")
    assert admin.errors, {:name=>["can't be blank"]}
  end

  test "create cap 2" do 
  	cap2 = CreateReseller.call("Dung", "dungth@hpu.edu.vn", "123123123")
  	assert User.reseller, [cap2]
  end

end
