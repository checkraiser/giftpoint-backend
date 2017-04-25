class GiftStatusesController < ApplicationController
  before_action :require_reseller
  before_action :require_campaign_customer, only: [:create]

  def index
  	@gift_status_form = GiftStatusForm.new
  end

  def find
    @gift_status_form = GiftStatusForm.new(
      gift_status_form_params
    )
    @campaign_customer = @gift_status_form.find
    flash[:error] = "No result" unless @campaign_customer
    render :index
  end

  def create
  	command = SetGiftStatus.call(@campaign_customer)
    if command.success?
      redirect_to promotion_path, notice: "Gift successfully set"
    else
      redirect_to promotion_path, error: "Error happens"
    end
  end

  private

  def gift_status_form_params
  	params.require(:gift_status_form).permit(:phone, :code)
  end

  def approve_campaign_customer_params
    params.require(:gift_status_form).permit(:campaign_customer_id)
  end

  def require_campaign_customer
    @campaign_customer ||= CampaignCustomer.find_by_id(approve_campaign_customer_params[:campaign_customer_id])
    redirect_to promotion_path and return unless @campaign_customer
  end
end
