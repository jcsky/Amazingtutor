class UsersController < ApplicationController
  before_action :find_user
  before_action :user_authority

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
    if params[:_remove_image] =="1"
      @user.image = nil
    end
    @user.update(user_params)
    if @user.save
      flash[:success] = "編輯成功"
      redirect_to "back"
    else
      render 'edit'
    end
  end

  private
  def user_authority
    redirect_to root_path if current_user==nil
  end

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:image, :email,:username,:first_name,:last_name,:birthday,
                                 :time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender)
  end
end
