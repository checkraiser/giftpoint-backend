module Api
  class CampaignsController < BaseController
  	def index
  	  present CampaignsPresenter.new(Campaign.page(params[:page]).per(params[:per_page]))
  	end
  end
end