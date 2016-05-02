class EvalutionsController < ApplicationController

  before_action :set_appointment

  def index
    @evalutions = Evalution.all
  end

  def new
    @evalution = Evalution.new
  end

  def create
    @evalution = @appointment.evalutions.where(user_id: current_user.id, teacher_id: @appointment.teacher_id ).first


    if @evalution.present?
      @evalution.update(:comment => params[:comment], :rating => params[:rating], :user_id => current_user.id, :appointment_id => @appointment.id, :teacher_id => @appointment.teacher_id )
      respond_to do |format|
        format.js
      end
    else
      @evalution = Evalution.new(:comment => params[:comment], :rating => params[:rating], :user_id => current_user.id, :appointment_id => @appointment.id, :teacher_id => @appointment.teacher_id )
      @evalution.save

      flash[:notice] = "successfully created"
      respond_to do |format|
        format.js
      end

    end

  end

  def show
    @evalution = Evalution.find(params[:id])

    respond_to do |format|
      format.html
      format.json {
        render :json => { :id => @appointment.id, :rating => @evalution.rating }
      }
    end
  end

  def update
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def evalution_params
    params.require(:evalution).permit(:comment, :rating)
  end

end
