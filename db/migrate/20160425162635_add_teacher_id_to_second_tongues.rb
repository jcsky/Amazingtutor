class AddTeacherIdToSecondTongues < ActiveRecord::Migration
  def change
    add_column :second_tongues , :teacher_id ,:integer
  end
end
