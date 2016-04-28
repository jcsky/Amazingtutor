class StudentReservationController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_reservation_section , :only =>[:create]
  def index

  end

  def create
    ActiveRecord::Base.transaction do
      @reservation_section_params[:start] = @reservation_section_params[:start].to_time
      @reservation_section_params[:end] = @reservation_section_params[:end].to_time
      # 查詢該時段是不是可被預約的時間
      avaiable_section_check = AvailableSection.lock.avaiable_section_check(@reservation_section_params[:start],
                                                                            @reservation_section_params[:end],
                                                                            @reservation_section_params[:teacher_id])
      # 查詢該時段是不是已經被預約
      appointment_check = Appointment.appointment_check(@reservation_section_params[:start],
                                                             @reservation_section_params[:end],
                                                             @reservation_section_params[:teacher_id])
      # 減掉user_avaiable_section的數值
      credit = UserAvailableSection.lock.query_credit(@reservation_section_params[:teacher_id],current_user)
      calc_section = (@reservation_section_params[:end].to_time - @reservation_section_params[:start].to_time) / 30.minute
      if avaiable_section_check and !appointment_check and credit[:available_section] >= calc_section.to_i
        # 設定預約課程
        Appointment.create_appointment(@reservation_section_params[:start],
                                       @reservation_section_params[:end],
                                       @reservation_section_params[:teacher_id],
                                       current_user)
        # 扣掉預約後的堂數
        UserAvailableSection.update_credit(credit,calc_section,'less')
      end
    end
  end

  def show

  end

  def destroy

  end

  private
  def set_reservation_section
    @reservation_section_params = params.permit(:start, :end, :teacher_id)
  end
end

