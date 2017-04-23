class HomeController < ApplicationController
  skip_before_action :require_login
  layout :home_layout
  
  def index
  end

  private

  def home_layout
  	return "landing" unless logged_in?
  	"application"
  end
end
