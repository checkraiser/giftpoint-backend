module ResourceHelper
  extend ActiveSupport::Concern

  def require_resource(resource, id)
  	@resource ||= resource.find_by_id(id)
  	redirect_to root_path and return unless @resource
  end
end
