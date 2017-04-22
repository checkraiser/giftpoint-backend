class SessionsController < ApplicationController
  def new
  	@session = Session.new
  end

  def create
  	@session = Session.new(session_params)
  	if @session.login(session)
  		redirect_to root_path, notice: "Welcome back"
  	else
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, notice: "You've logged out"
  end

  private

  def session_params
  	params.require(:session).permit(:email, :password)
  end
end
