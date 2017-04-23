class CustomersController < ApplicationController
  before_action :require_admin
  before_action :require_campaign, only: [:import]

  def index
  	@resources = paginate(Customer)
  end

  def import
  	command = BatchFileImportCustomers.call(@campaign, params[:file])
  	if command.success?
  	  redirect_to campaign_path(@campaign), success: "Customers uploaded"
  	else
  	  redirect_to campaign_path(@campaign), error: "There is error when importing"
  	end
  end

  def generate_code
  	
  end

  private

  def require_campaign
  	@campaign ||= Campaign.find_by_id(params[:campaign_id])
  	redirect_to customers_path and return unless @campaign
  end
end
