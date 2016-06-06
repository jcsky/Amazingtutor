class EvaluationsController < ApplicationController

  before_action :set_appointment

  def index
    @evaluations = Evaluation.all
  end

  def new
    @evaluation = Evaluation.new
  end


  def create
    if params[:type].to_i == 0
      if current_user.id == @appointment.user_id
        @evaluation = @appointment.evaluations.where(evaluatable_type: "User",
                                                      evaluatable_id: current_user.id, evaluated_id: @appointment.teacher_id ).first
        unless @evaluation.present?
          @evaluation = current_user.evaluations.create!(:comment => params[:comment], :rating => params[:rating],
                                                        :appointment_id => @appointment.id,
                                                        :evaluated_id => @appointment.teacher_id )
        end
      end

    elsif params[:type].to_i == 1
      if current_user.teacher.id == @appointment.teacher_id
        @evaluation = @appointment.evaluations.where(evaluatable_type: "Teacher",
                                                    evaluatable_id: current_user.teacher, evaluated_id: @appointment.user_id ).first

        unless @evaluation.present?
          @evaluation = current_user.teacher.evaluations.create!(:comment => params[:commentTa],
                                                        :appointment_id => @appointment.id,
                                                        :evaluated_id => @appointment.user_id )
        end
      end
    end

    flash[:notice] = "successfully created"
    respond_to do |format|
      format.js
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
