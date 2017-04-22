class CreateCampaign
  include PrependErrors

  def initialize(name, content, start_time, end_time, location, count)
    @name = name
  	@content = content
    @start_time = start_time
    @end_time = end_time
    @location = location
    @count = count
  end

  def call
  	campaign
  end

  private

  attr_accessor :name, :content, :start_time, :end_time, :location, :count

  def campaign
  	campaign = Campaign.new name: name,
                            content: content,
                            start_time: start_time,
                            end_time: end_time,
                            location: location,
                            count: count
    
    return campaign if campaign.save
  	prepend_errors(campaign)
    nil
  end
end