require 'test_helper'

class BatchFileImportResellersTest < ActiveSupport::TestCase
  test "success" do 
  	command = BatchFileImportResellers.call(resellers_file)
  	assert command.result.count, 2
  end
end