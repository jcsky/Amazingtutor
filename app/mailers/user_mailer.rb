class UserMailer < ApplicationMailer
  default :from => "amazingtutor <amazingtutor@amazingtutor.com>"

  def notify_teacher_new_appointment(user, teacher_user)
    @user = user
    @teacher_user = teacher_user
    if teacher_user.alternate_email
      mail(:to => teacher_user.alternate_email, :subject => "You have a new appointment-AmazingTutor")
    else
      mail(:to => teacher_user.email, :subject => "You have a new appointment-AmazingTutor")
    end
  end


end
