class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_time_zone, :if => :user_signed_in?

  private
  def set_time_zone
    if !current_user.time_zone.nil?
      Time.zone = current_user.time_zone
    end
  end
end
