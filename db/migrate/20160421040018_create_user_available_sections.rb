class CreateUserAvailableSections < ActiveRecord::Migration
  def change
    create_table :user_available_sections do |t|
      t.integer :user_id
      t.integer :teacher_id
      t.integer :available_section

      t.timestamps null: false
    end
  end
end
