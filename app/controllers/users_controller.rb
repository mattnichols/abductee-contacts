class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.create(params.require(:user).permit(:email, :password, :password_confirmation))
		if @user.valid?
			session[:user_id] = @user.id
			respond_to do |format|
				format.html do
					redirect_to contacts_path, flash: { info: "Welcome!" } 
				end
			end
		else
			respond_to do |format|
				format.html do
					flash[:error] = "Unable to create user"
					render "new"
				end
			end
		end
	end
end