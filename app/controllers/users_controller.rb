class UsersController < ApplicationController
  before_action :require_admin

  def index
  	@resellers = paginate User.reseller
  end

  def new
  end

  def create
  end

  def import_resellers
  	import_command = BatchFileImportResellers.call(params[:file])
  	if import_command.success?
  	  redirect_to users_path, notice: "Users successfully imported"
  	else
  	  redirect_to users_path, danger: import_command.errors.to_s
  	end
  end
end
