class AddTeacherIdToEvalutions < ActiveRecord::Migration
  def change
    add_column :evalutions, :teacher_id, :integer

    add_index :evalutions, :teacher_id
  end
end
