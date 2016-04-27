class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :user_id
      t.string  :youtube
      t.text    :introduction
      t.integer :trial_fee
      t.integer :one_fee
      t.integer :five_fee
      t.integer :ten_fee
      t.string :gathering_way
      t.timestamps null: false
    end
  end
end
