require 'test_helper'

class FileImportTest < ActiveSupport::TestCase
  test "success " do 
  	command = FileImport.call(customers_file)
  	assert command.result, [
  		{:name=>"Dung", :phone=>1214115322.0}, 
  		{:name=>"Test3", :phone=>12345.0}, 
  		{:name=>"Test4", :phone=>123.0}]
  end

  test "fail" do 
  	command = FileImport.call("")
  	assert command.errors
  end
end