require 'test_helper'

class CampaignFormTest < ActiveSupport::TestCase
  test "success save" do 
  	params = {
  	  name: "fd", content: "fsdf", start_time: "04/28/2017", end_time: "04/30/2017", 
  	  product_count: 3, product_id: product.id, location: "Viet Nam"
  	}
  	form = CampaignForm.new(params)
  	form.save
  	p form
  	#assert form.errors.messages, {:location=>["can't be blank"]}
  end
end
