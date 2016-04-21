class CreateAvailableSections < ActiveRecord::Migration
  def change
    create_table :available_sections do |t|
      t.integer :teacher_id
      t.integer :appointment_id
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
