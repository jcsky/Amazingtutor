class CreateEvalutions < ActiveRecord::Migration
  def change
    create_table :evalutions do |t|
      t.string :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
