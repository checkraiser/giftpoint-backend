class CustomersController < ApplicationController
  before_action :require_admin
  before_action :require_campaign, only: [:import, :generate_code, :export, :approve_all, :import_sms]

  def index
  	@resources = paginate(Customer)
  end

  def import
  	command = BatchFileImportCustomers.call(@campaign, params[:file])
  	if command.success?
  	  redirect_to campaign_path(@campaign), success: "Customers uploaded"
  	else
  	  redirect_to campaign_path(@campaign), danger: "There is error when importing"
  	end
  end

  def generate_code
  	command = BatchGenerateCustomerCodes.call(@campaign.campaign_customers)
    if command.success?
      redirect_to campaign_path(@campaign), success: "Code generated"
    else
      redirect_to campaign_path(@campaign), danger: "There is error when importing"
    end
  end

  def export
    @campaign_customers = @campaign.campaign_customers.exportable.includes(:customer)
    respond_to do |format|
      format.xlsx
    end
  end

  def approve_all
    command = ApproveCampaignCustomers.call(@campaign.campaign_customers)
    if command.success?
      redirect_to campaign_path(@campaign), success: "Code generated"
    else
      redirect_to campaign_path(@campaign), danger: "There is error when importing"
    end
  end

  def import_sms
    command = BatchFileSetSmsCustomers.call(@campaign.campaign_customers, params[:file])
    if command.success?
      redirect_to campaign_path(@campaign), success: "Sms set"
    else
      redirect_to campaign_path(@campaign), danger: "There is error when setting sms"
    end
  end
  
  private

  def require_campaign
  	@campaign ||= Campaign.find_by_id(params[:campaign_id])
  	redirect_to customers_path and return unless @campaign
  end
end
