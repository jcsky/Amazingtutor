class UserMailer < ApplicationMailer
  default :from => "amazingtutor <amazingtutor@amazingtutor.com>"

  def notify_teacher_new_appointment(user, teacher_user, startTime)
    @user = user
    @teacher_user = teacher_user
    @startTime = startTime
    if teacher_user.alternate_email
      mail(:to => teacher_user.alternate_email, :subject => "You have a new appointment-AmazingTutor")
    else
      mail(:to => teacher_user.email, :subject => "You have a new appointment-AmazingTutor")
    end
  end

  def notify_student_new_appointment(user, teacher_user, startTime)
    @user = user
    @teacher_user = teacher_user
    @startTime = startTime
    if teacher_user.alternate_email
      mail(:to => user.alternate_email, :subject => "You book a new appointment-AmazingTutor")
    else
      mail(:to => user.email, :subject => "You book a new appointment-AmazingTutor")
    end
  end


end
