class RenameEducationColumn < ActiveRecord::Migration
  def change
    rename_column :educations, :user_id, :teacher_id
  end
end
