class CampaignsController < ApplicationController
  before_action :require_admin

  def index
    @resources = Campaign.page(params[:page]).per(params[:per_page])
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
end
