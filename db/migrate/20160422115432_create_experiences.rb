class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.string  :company_name
      t.string  :description

      t.timestamps null: false
    end
  end
end
