class StudentReservationController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_reservation_section , :only =>[:create]
  def index

  end

  def free_trial
    @teacher = Teacher.find(params[:teacher_id])
    if @teacher.trial_fee == 0 && (current_user.user_available_sections.where(teacher_id: @teacher).first.nil? || current_user.user_available_sections.where(teacher_id: @teacher).first.trailed == false)
    new_trial = current_user.user_available_sections.new(teacher_id:@teacher.id,trailed:true,available_section:1)
    # byebug
    if new_trial.save
        redirect_to mytutor_user_path(current_user)
      end
    end

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

