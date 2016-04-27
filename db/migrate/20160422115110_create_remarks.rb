class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.integer :teacher_id
      t.integer :user_id
      t.text    :desciption
      
      t.timestamps null: false
    end
  end
end
