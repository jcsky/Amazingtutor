class MessagesController < ApplicationController
  def create
    if params[:message]
      @admin = User.where(email: 'admin@gmail.com')
      if current_user
        Message.create(friend_id: @admin.ids.first, user_id: current_user.id,
                       message: params[:message][:message], problem: params[:message][:problem],
                       email: params[:message][:email])
      else
        Message.create(friend_id: @admin.ids.first, message: params[:message][:message],
                       problem: params[:message][:problem], email: params[:message][:email])
      end
      redirect_to :back
    end
  end

  private

  def message_params
    params.require(:teacher).permit(:user_id, :friend_id, :message, :problem, :email)
end
end
