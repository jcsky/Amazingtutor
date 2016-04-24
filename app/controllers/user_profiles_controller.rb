class UserProfilesController < ApplicationController

  before_action :find_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @profile = @user.get_profile
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:username,:first_name,:last_name,:birthday,:time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender)
  end
end
