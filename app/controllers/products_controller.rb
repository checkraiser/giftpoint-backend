class ProductsController < ApplicationController
  before_action :require_admin

  def index
  	@resources = paginate(Product)
  end

  def new
  end

  def create
  end

  def import
  	command = FileImportProducts.call(params[:file])
  	if command.success?
  	  redirect_to products_path, success: "Products uploaded"
  	else
  	  redirect_to products_path, error: "There is error when importing"
  	end
  end
end
