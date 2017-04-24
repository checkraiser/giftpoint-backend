class GiftStatusesController < ApplicationController
  before_action :require_reseller

  def index
  	@gift_status_form = GiftStatusForm.new
  end

  def create
  	@gift_status_form = GiftStatusForm.new(gift_status_form_params)
  	if @gift_status_form.save
  	  redirect_to gift_statuses_path, notice: "Code is set successfully"
  	else
  	  render :index
  	end
  end

  private

  def gift_status_form_params
  	params.require(:gift_status_form).permit(:phone, :code)
  end
end
