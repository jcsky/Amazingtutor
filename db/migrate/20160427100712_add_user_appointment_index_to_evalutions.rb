class AddUserAppointmentIndexToEvalutions < ActiveRecord::Migration
  def change
    add_reference :evalutions, :appointment, index: true
    add_reference :evalutions, :user, index: true
  end
end
