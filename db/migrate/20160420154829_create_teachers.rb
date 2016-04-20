class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :teacher_id, :index => true

      t.timestamps null: false
    end
  end
end
