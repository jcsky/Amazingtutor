class EvaluationsController < ApplicationController

  before_action :set_appointment

  def index
    @evaluations = Evaluation.all
  end

  def new
    @evaluation = Evaluation.new
  end


  def create


    @evaluation = @appointment.evaluations.where(user_id: current_user.id, teacher_id: @appointment.teacher_id ).first


    if @evaluation.present?
      @evaluation.update(:comment => params[:comment], :rating => params[:rating], :user_id => current_user.id, :appointment_id => @appointment.id, :teacher_id => @appointment.teacher_id )
      respond_to do |format|
        format.js
      end
    else
      @evaluation = Evaluation.new(:comment => params[:comment], :rating => params[:rating], :user_id => current_user.id, :appointment_id => @appointment.id, :teacher_id => @appointment.teacher_id )
      @evaluation.save

      flash[:notice] = "successfully created"
      respond_to do |format|
        format.js
      end

    end

  end

  def show
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      format.html
      format.json {
        render :json => { :id => @appointment.id, :rating => @evaluation.rating }
      }
    end
  end

  def update
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:comment, :rating)
  end

end
