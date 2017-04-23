module Pagination
  extend ActiveSupport::Concern

  def paginate(resources)
  	resources.page(params[:page]).per(params[:per_page])
  end
end