class MessagesController < ApplicationController
  def create
    if params[:message]
      @admin = User.where(email: 'admin@gmail.com')
      if current_user
        message = Message.create(friend_id: @admin.ids.first, user_id: current_user.id,
                       message: params[:message][:message], problem: params[:message][:problem],
                       email: params[:message][:email])
      else
        message = Message.create(friend_id: @admin.ids.first, message: params[:message][:message],
                       problem: params[:message][:problem], email: params[:message][:email])
      end

      if message
        # render :json => {':hello' => '123'}
        render :json => {:success => true, :message => message.message}.to_json
      else
        render :json => {:error => true}.to_json
      end

    end
  end

  private

  def message_params
    params.require(:teacher).permit(:user_id, :friend_id, :message, :problem, :email)
end
end
