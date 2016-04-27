class RenameCertificatesColumn < ActiveRecord::Migration
  def change
      rename_column :certificates, :user_id, :teacher_id
  end
end
