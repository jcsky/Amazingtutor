class TeachersController < ApplicationController
  before_action :teacher_authority, except: [:profile, :index]
  before_action :get_teacher, except: :profile
  before_action :find_teacher, only: [:classes, :profile]
  before_action :get_hangouts_url

  # 只有user裡面的author得值要等於teacher才可以進來 但大家都有第一次可能進來沒有teacher
  # 所以全部要before_action先建好teacher 如果已經有了就用已經有的

  def index
    @teachers = Teacher.all
    @appointments = Appointment.all
    @evaluations = Evaluation.all
  end

  def introduce
    @teacher.teacher_languageships.new if @teacher.teacher_languageships.empty?
    render layout: 'welcome'
  end

  def calendar
  end

  def classes
    @appointments = @teacher.appointments
  end

  def profile
    redirect_to root_path if @teacher.check != 'checked'
    @evaluations = Evaluation.all.where(evaluatable_type: 'User', evaluated_id: @teacher)
    @teacher = Teacher.find_by_id(params[:id])
    unless current_user.nil?
      @user_available_sections = current_user.user_available_sections.find_by_teacher_id(params[:id])
    end
  end

  def price
  end

  def gathering
    @gathering = @teacher.gathering_way
  end

  def education
    @language = @teacher.educations.build if @teacher.educations.empty?
    @language = @teacher.experiences.build if @teacher.experiences.empty?
    @language = @teacher.certificates.build if @teacher.certificates.empty?
  end

  def youtube
  end

  def hangouts_url
  end

  def update
    if params[:teacher][:youtube]
      if params[:teacher][:youtube].include?('https://www.youtube.com/watch')
        @teacher.youtube = params[:teacher][:youtube]
        @teacher.save
        # redirect_to :back
        flash[:alert] = 'Save success'
        redirect_to :back
      else
        flash[:alert] = 'Save fail because video not from Youtube'
        redirect_to :back
      end
    else
      @teacher.update(teacher_params)
      if @teacher.save
        redirect_to :back
        flash[:alert] = 'Save success'
      else
        flash[:alert] = 'Save fail'
      end
    end

  end

  private

  def find_teacher
    @teacher = Teacher.find(params[:id])
  end

  def get_teacher
    @teacher = if current_user.teacher
                 current_user.teacher
               else
                 current_user.create_teacher
               end
  end

  def get_hangouts_url
    if @teacher.hangouts_url.blank?
      charset = ""
      url = ""
      charset = (0...9).map { ('a'..'z').to_a[ rand(26)] }.join
      url =  "https://talkgadget.google.com/hangouts/_/n"+charset+"aelp4l25okzw3tw4e?hl=en-US"
      @teacher.hangouts_url = url
      @teacher.save
    end
  end

  def teacher_authority
    if current_user.nil? || current_user.authority != 'teacher'
      redirect_to root_path
    end
  end

  def teacher_params
    params.require(:teacher).permit(:user_id, :youtube, :introduction, :trial_fee,
                                    :one_fee, :five_fee, :ten_fee, :gathering_way,
                                    language_ids: [],
                                    languages_attributes: [:language, :_destroy, :id],
                                    experiences_attributes: [:company_name, :description, :_destroy, :id],
                                    educations_attributes: [:school, :major, :_destroy, :id],
                                    certificates_attributes: [:name, :score, :_destroy, :id])
  end
end
