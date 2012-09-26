class SessionsController < ApplicationController
  layout 'ses'
  def new
  end
  def create
  	user = login(params[:username],params[:password],params[:remember_me])
  	if user
  		redirect_back_or_to root_url, :notice => 'Logged in'
  	else
  		flash.now.alert = 'Log in invalid'
  		render :new
  	end
  end
  def destroy
  	logout
  	redirect_to root_url, :notice =>'log out'
  end
end

