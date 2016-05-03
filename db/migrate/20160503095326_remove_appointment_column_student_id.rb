class RemoveAppointmentColumnStudentId < ActiveRecord::Migration
  def change
    remove_column :appointments , :student_id
  end
end
