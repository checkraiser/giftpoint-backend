class UsersController < ApplicationController
  before_action :require_admin
  before_action :require_user, only: [:update]

  def index
  	@resellers = paginate User.reseller
  end

  def new
  end

  def update
    command = UpdateRecord.call(user, user_params)
    if command.success?
      redirect_to users_path, success: "Updated successfully"
    else
      redirect_to users_path, error: "Update error"
    end
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :location)
  end

  def require_user
    @user ||= User.find_by_id(params[:id])
    redirect_to users_path, error: "User not found" and return unless @user
  end

  def user
    @user
  end
end
