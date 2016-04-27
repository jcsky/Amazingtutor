class ReservationListController < ApplicationController
  def index

  end

  def show

  end

  private
  def set_params
    params.permit(:date , :teacher_id)
  end
end
