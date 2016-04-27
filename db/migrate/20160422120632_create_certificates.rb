class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.integer :user_id
      t.string  :name
      t.string  :score

      t.timestamps null: false
    end
  end
end
