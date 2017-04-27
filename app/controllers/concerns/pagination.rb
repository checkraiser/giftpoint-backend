module Pagination
  extend ActiveSupport::Concern

  def paginate(resources)
  	if resources.kind_of?(Array)
  	  Kaminari.paginate_array(resources).page(params[:page]).per(params[:per_page])
  	else
  	  resources.page(params[:page]).per(params[:per_page])
  	end
  end
end