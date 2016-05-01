class TeacherCalendarsController < ApplicationController
  before_action :set_available_section, :only => [:create]
  before_action :set_reservaton_list_params, :only => [:show , :index ,:teacher_available , :booked_section]

  def index
    @teacher = User.find(@reservaton_list_params[:id]).teacher

    @reservation_list = AvailableSection.query_reservation_time_list_by_date( @reservaton_list_params[:id] , @reservaton_list_params[:date])
  end

  def create
    start_time = AvailableSection.time_shif_to_half_an_hour(@availabele_section_params[:start].to_time, 'after')
    end_time = AvailableSection.time_shif_to_half_an_hour(@availabele_section_params[:end].to_time, 'before')
    return_insert_sections = AvailableSection.check_section_insertalbe_and_bluk_insert(start_time,end_time)
    respond_to do |format|
      format.json { render :json => return_insert_sections.to_json }
    end
  end

  def show
    reservation_list = AvailableSection.query_reservation_time_list_by_date( @reservaton_list_params[:id] , @reservaton_list_params[:date])
    render :json => reservation_list.to_json
  end

  def teacher_available
    render AvailableSection.teacher_available_by_date(@reservaton_list_params[:id] , @reservaton_list_params[:date]).to_json
  end

  def booked_section
    render Appointment.booked_section_by_date(@reservaton_list_params[:id] , @reservaton_list_params[:date]).to_json
  end

  private

  def set_available_section
    @availabele_section_params = params.permit(:start, :end)
  end

  def set_reservaton_list_params
    @reservaton_list_params = params.permit(:date , :id)
  end
end
