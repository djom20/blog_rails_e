class UserSessionController < ApplicationController
	def show
		redirect_to(users_path)
	end
	def new
		@user = User.new
	end
	def create
		if @user = login(params[:username], params[:password])
			redirect_back_or_to(articles_path,message: 'Welcom!')
		else
			flash.now[:alert] = 'login failed!'
			render action: :new
		end
	end
	def destroy
		loguot
		redirect_to(:users, message: 'Logged out!')
	end
end
