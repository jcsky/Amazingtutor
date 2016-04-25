class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string   :location
      t.string   :currency
      t.string   :tongue
      t.string   :born_form
      t.string   :live_in
      t.boolean  :gender
      t.datetime :time_zone
      t.integer  :user_id , :index=> true
      t.datetime :birthday
      t.string   :first_name
      t.string   :last_name

      t.timestamps null: false
    end
  end
end
