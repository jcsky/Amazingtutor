class UsersController < ApplicationController
  before_action :find_user
  def classes
  end
  def remark
  end
  def changepassword
  end
  def mytutor
  end
  def profile
  end

  def update
    @user.update(user_params)
    if @user.save
        flash[:success] = "編輯成功"
        redirect_to root_path
      else
        render 'edit'
      end
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,:username,:first_name,:last_name,:birthday,
    :time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender)
  end
end
