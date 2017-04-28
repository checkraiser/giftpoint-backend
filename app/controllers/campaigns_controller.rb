class CampaignsController < ApplicationController
  before_action :require_admin
  before_action :require_campaign, only: [:show, :edit, :update]  
  before_action :require_products, only: [:new]

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
    command = UpdateRecord.call(campaign, update_campaign_params)
    if command.success?
      redirect_to campaigns_path, success: "Updated successfully"
    else
      redirect_to campaigns_path, error: "Update error"
    end
  end

  def cost_report
    query = CampaignCostReportQuery.new(params[:date1], params[:date2])
    @resources = paginate(query.render)
  end

  def time_report
    query = CampaignTimeReportQuery.new
    @resources = paginate(query.render)
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

  def update_campaign_params
    params.require(:campaign).permit(
      :name,
      :content,
      :location,
      :product_count
    )
  end

  def require_campaign
    @campaign ||= Campaign.find_by_id(params[:id])
    redirect_to root_path and return unless @campaign
  end

  def require_products
    @products ||= Product.all
  end

  def campaign
    @campaign
  end
end
