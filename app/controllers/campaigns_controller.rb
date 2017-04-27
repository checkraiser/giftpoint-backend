class CampaignsController < ApplicationController
  before_action :require_admin
  before_action :require_campaign, only: [:show, :edit, :update]  
  before_action :require_cities, only: [:index]

  def index    
    query = CampaignSearchQuery.new(params[:date], params[:city], params[:product_name])
    @resources = paginate(query.render)
  end

  def new
    @campaign = CampaignForm.new
  end

  def create
    @campaign = CampaignForm.new(campaign_params)
    if @campaign.save
      redirect_to campaigns_path, success: "Campaign created"
    else
      render :new
    end
  end

  api :GET, '/campaigns/:id'
  def show
    @campaign_customers = paginate @campaign.campaign_customers
  end

  def edit
  end

  def update
  end

  private

  def campaign_params
    params.require(:campaign_form).permit(
      :name, 
      :content, 
      :start_time, 
      :end_time, 
      :location, 
      :product_count,
      :product_id
    )
  end

  def require_campaign
    @campaign ||= Campaign.find_by_id(params[:id])
    redirect_to root_path and return unless @campaign
  end

  def require_cities
    @cities ||= Campaign.pluck(:location)
  end
end
