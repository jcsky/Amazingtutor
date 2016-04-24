class CreateTeacherProfiles < ActiveRecord::Migration
  def change
    create_table :teacher_profiles do |t|
      t.integer :teacher_id
      t.string  :youtube
      t.text    :introduction
      t.integer :trial_fee
      t.integer :one_fee
      t.integer :five_fee
      t.integer :ten_fee
      t.integer :gathering_way
      t.timestamps null: false
    end
  end
end
