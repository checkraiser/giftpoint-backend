class ProductsController < ApplicationController
  before_action :require_admin
  before_action :require_product, only: [:update]

  def index
  	@resources = paginate(Product)
    query = CampaignProductsQuery.new(params[:campaign_name], params[:date1], params[:date2])
    favorite_products_query = FavoriteProductsQuery.new(params[:date1], params[:date2])
    @campaign_products = paginate(query.render)
    @favorite_products = paginate(favorite_products_query.render)
  end

  def new
  end

  def update
    command = UpdateRecord.call(product, product_params)
    if command.success?
      redirect_to products_path, success: "Updated successfully"
    else
      redirect_to products_path, error: "Update error"
    end
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

  private

  def product_params
    params.require(:product).permit(:name, :code, :price, :unit)
  end

  def require_product
    @product ||= Product.find_by_id(params[:id])
    redirect_to products_path, error: "Product not found" and return unless @product
  end

  def product
    @product
  end
end
