class TeachersController < ApplicationController
  before_action :teacher_authority ,except: :profile
  before_action :get_teacher,except: :profile

  # 只有user裡面的author得值要等於teacher才可以進來 但大家都有第一次可能進來沒有teacher
  # 所以全部要before_action先建好teacher 如果已經有了就用已經有的

  def index
    @teachers = Teacher.all
    @appointments = Appointment.all
    @evaluations = Evaluation.all

  end

  def introduce
    @teacher.teacher_languageships.new if @teacher.teacher_languageships.empty?
  end

  def calendar
  end

  def classes
  end

  def profile
    @user = current_user
    @teacher = Teacher.find(params[:id])
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

  def update
    if params[:teacher][:youtube]
      if params[:teacher][:youtube].include?('https://www.youtube.com/watch')
        @teacher.youtube = params[:teacher][:youtube]
        @teacher.save
        # redirect_to :back
        flash[:alert] = 'Save success'
        redirect_to :back
      else
        flash[:alert] = 'Save fail'
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

  def get_teacher
    if current_user.teacher
      @teacher =current_user.teacher
     else
      @teacher = current_user.create_teacher
    end
  end

  def teacher_authority
     if current_user == nil || current_user.authority != 'teacher'
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
