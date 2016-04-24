class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :school
      t.string :major

      t.timestamps null: false
    end
  end
end
