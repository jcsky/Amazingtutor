class UserMailer < ApplicationMailer
  default :from => "amazingtutor <amazingtutor@amazingtutor.com>"

  def notify_teacher_new_appointment(user, teacher)
    @user = user
    @teacher = teacher
    if teacher.email
      mail(:to => teacher.alternate_email, :subject => "You have a new appointment-AmazingTutor")
    else
      mail(:to => teacher.alternate_email, :subject => "You have a new appointment-AmazingTutor")
    end
  end

end
