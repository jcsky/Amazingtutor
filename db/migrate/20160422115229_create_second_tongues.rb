class CreateSecondTongues < ActiveRecord::Migration
  def change
    create_table :second_tongues do |t|
      t.integer :user_id
      t.string :language
      
      t.timestamps null: false
    end
  end
end
