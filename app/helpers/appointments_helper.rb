module AppointmentsHelper
  def evaluatable_type_is_user(appointment)
    appointment.evaluations.where(evaluatable_type: "User").exists?
  end

  def evaluatable_type_is_teacher(appointment)
    appointment.evaluations.where(evaluatable_type: "Teacher").exists?
  end

end
