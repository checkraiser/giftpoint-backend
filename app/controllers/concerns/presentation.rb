module Presentation
  extend ActiveSupport::Concern

  included do
    helper_method :resource
  end

  private

  def present(object, status = nil, with: nil)
    return object if object.blank?
    klass = with || presenter_class(object)

    @resource =
      if klass
        klass.decorate object
      else
        object
      end
    p @resource
  end

  def resource
    @resource
  end

  def presenter_class(object)
    object = object.respond_to?(:to_a) ? object.first : object
    "#{object.class}Presenter".safe_constantize
  end
end