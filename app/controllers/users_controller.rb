class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create, :show, :index]
    before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end


  def edit
    @user = current_user
  end

  def update
    if @user.authenticate(params[:user][:current_password])
      if @user.update user_params
        redirect_to edit_users_path, notice: "Profile Updated"
      else
        flash[:alert] = "See errors below"
        render :edit
      end
    else
      flash[:alert] = "Wrong Password"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = current_user
  end
end
