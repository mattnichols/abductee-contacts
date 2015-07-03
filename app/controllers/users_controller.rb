class UsersController < ApplicationController

	def new
		@user = User.new
		flash[:error] = "hi there!"
	end

end