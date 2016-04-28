class AddStudentIdToAppoiment < ActiveRecord::Migration
  def change
    add_column :appointments, :student_id, :integer
  end
end
