class CreateCampaign < BaseCommand
  prepend SimpleCommand
  
  def initialize(name, content, start_time, end_time, location, product_count, product)
    @name = name
  	@content = content
    @start_time = start_time
    @end_time = end_time
    @location = location
    @product_count = product_count
    @product = product
  end

  def call
  	create_campaign
  end

  def self.dependencies
    []
  end

  private

  attr_accessor :name, :content, :start_time, :end_time, :location, :product_count, :product

  def create_campaign
  	campaign = Campaign.new name: name,
                            content: content,
                            start_time: start_time,
                            end_time: end_time,
                            location: location,
                            product_count: product_count,
                            product: product
    
    return campaign if campaign.save
  	prepend_errors(campaign)
    nil
  rescue => e 
    errors.add :create_campaign, e.message
  end
end