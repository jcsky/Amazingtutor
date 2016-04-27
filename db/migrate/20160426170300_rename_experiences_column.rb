class RenameExperiencesColumn < ActiveRecord::Migration
  def change
      rename_column :experiences, :user_id, :teacher_id
  end
end
