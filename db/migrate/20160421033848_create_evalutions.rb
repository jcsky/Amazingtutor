class CreateEvalutions < ActiveRecord::Migration
  def change
    create_table :evalutions do |t|
      t.string :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end

# 少appointments_id
# 少user_id
# 少teacher_id
