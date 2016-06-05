module WelcomeHelper
  def show_week
    week = "All" if params[:week].nil?
    week = "Monday" if  params[:week] == "1"
    week = "Tuesday"if params[:week] == "2"
    week = "Wednesday" if params[:week] == "3"
    week = "Thursday" if params[:week] == "4"
    week = "Friday" if  params[:week] == "5"
    week = "Saturday" if params[:week] == "6"
    week = "Sunday" if params[:week] == " 7"
    week
  end

  def show_language
   lan = "ALL" if params[:language_id].nil?
   lan = Language.find(params[:language_id]).language if params[:language_id].present?
   lan
  end
end
