class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :teacher_id
      t.integer :section
      t.integer :amount
      t.string :status
      t.string :payment_status
      t.string :attendance_status

      t.timestamps null: false
    end
  end
end
