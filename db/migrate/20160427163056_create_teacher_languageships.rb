class CreateTeacherLanguageships < ActiveRecord::Migration
  def change
    create_table :teacher_languageships do |t|
      t.integer :teacher_id
      t.integer :language_id

      t.timestamps null: false
    end
  end
end
