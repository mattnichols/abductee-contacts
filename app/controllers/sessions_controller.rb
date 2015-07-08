class	SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to contacts_path, flash: { info: "Login successful" }
    else
    	flash[:error] = "Invalid login"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, flash: { info: "Logout successful" }
  end
end