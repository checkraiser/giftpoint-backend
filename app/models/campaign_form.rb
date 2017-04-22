class CampaignForm < BaseForm
  
  attr_accessor :name, :content, :start_time, :end_time, :location, :product_count, :product_id

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location, presence: true
  validates :product_count, presence: true, numericality: { greater_than: 0 }
  validates :product_id, presence: true

  def save
  	if valid?
  	  product = Product.find_by_id(product_id)
      start_time = DateTime.parse(start_time) rescue Time.current
      end_time = DateTime.parse(end_time) rescue Time.current
  	  if product
  	  	command = CreateCampaign.call(
  	  	  name, content, start_time, end_time, location, product_count, product
  	  	)
  	  	return command.result if command.success?
  	  	append_errors command
  	  else
  	  	errors.add :campaign_form, "Product not found"
  	  end
  	end
  end
end