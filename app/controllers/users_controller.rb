class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.create(params.require(:user).permit(:email, :password, :password_confirmation))
		respond_to do |format|
			format.html do
				if @user.valid?
					flash[:info] = "User created!"
					redirect_to root_path
				else
					flash[:error] = "Unable to create user"
					render "new"
				end
			end
		end
	end

end