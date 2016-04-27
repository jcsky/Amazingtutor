class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.integer :teacher_id
      t.string :language

      t.timestamps null: false
    end
  end
end
