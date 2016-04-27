class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :teacher_id
      t.integer :section

      t.timestamps null: false
    end
  end
end
# 少 user_id 
