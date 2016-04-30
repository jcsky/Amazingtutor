class ApiV1::AppointmentsController < ApiController

  def show
    @evalution = Evalution.find(params[:id])
  end
end