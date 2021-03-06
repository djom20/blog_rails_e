class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def edit
    if current_user && (current_user.id == params[:id] || current_user.id == 1 )
        @user = User.find(params[:id])
    else
        redirect_to root_url, :notice => "Acceso denegado"
    end
  end
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => 'Signed up'
    else
      render :new
    end
  end
end
