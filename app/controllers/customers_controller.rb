class CustomersController < ApplicationController
  before_action :require_admin
  before_action :require_campaign, only: [:import, :generate_code, :export, :approve_all, :import_sms]
  before_action :require_customer, only: [:show, :update]

  def index
  	@resources = paginate(Customer)
  end

  def update
    command = UpdateRecord.call(customer, customer_params)
    if command.success?
      redirect_to customers_path, success: "Updated successfully"
    else
      redirect_to customers_path, error: "Update error"
    end
  end

  def show
    query = CustomerQuery.new(customer.id, params[:date1], params[:date2])
    @resource = customer
    @resources = paginate(query.render)
  end

  def import
  	command = BatchFileImportCustomers.call(campaign, params[:file])
  	if command.success?
  	  redirect_to campaign_path(@campaign), success: "Customers uploaded"
  	else
  	  redirect_to campaign_path(@campaign), danger: "There is error when importing"
  	end
  end

  def generate_code
  	command = BatchGenerateCustomerCodes.call(campaign.campaign_customers)
    if command.success?
      redirect_to campaign_path(campaign), success: "Code generated"
    else
      redirect_to campaign_path(campaign), danger: "There is error when importing"
    end
  end

  def export
    @campaign_customers = campaign.campaign_customers.exportable.includes(:customer)
    respond_to do |format|
      format.xlsx
    end
  end

  def approve_all
    command = ApproveCampaignCustomers.call(campaign.campaign_customers)
    if command.success?
      redirect_to campaign_path(campaign), success: "Code generated"
    else
      redirect_to campaign_path(campaign), danger: "There is error when importing"
    end
  end

  def import_sms
    command = BatchFileSetSmsCustomers.call(campaign.campaign_customers, params[:file])
    if command.success?
      redirect_to campaign_path(campaign), success: "Sms set"
    else
      redirect_to campaign_path(campaign), danger: "There is error when setting sms"
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :phone, :city, :address)
  end

  def require_campaign
  	@campaign ||= Campaign.find_by_id(params[:campaign_id])
  	redirect_to customers_path, error: "Campaign not found" and return unless @campaign
  end

  def campaign
    @campaign
  end

  def require_customer
    @customer ||= Customer.find_by_id(params[:id])
    redirect_to customers_path, error: "Customer not found" and return unless @customer
  end

  def customer
    @customer
  end
end
