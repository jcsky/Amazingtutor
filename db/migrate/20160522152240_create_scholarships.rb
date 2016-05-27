class CreateScholarships < ActiveRecord::Migration
  def change
    create_table :scholarships do |t|
          t.integer :user_id
          t.integer :new_user_id
          t.string  :bonus

      t.timestamps null: false
    end
  end
end
