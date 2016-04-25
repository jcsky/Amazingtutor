class UserProfilesController < ApplicationController

  before_action :find_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user.get_profile
    @user.update(user_params)
    if @user.save
        flash[:success] = "編輯成功"
        redirect_to root_path
      else
        render 'edit'
      end
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:email,:username,profile_attributes: [:first_name,:last_name,:birthday,:time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender])
  end

end
