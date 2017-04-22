class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorHandling
  include Authentication
  include Authorization
  include Presentation
end
