class ApiV1::AppointmentsController < ApiController

  def show
    @evaluation = Evaluation.find(params[:id])
  end
end