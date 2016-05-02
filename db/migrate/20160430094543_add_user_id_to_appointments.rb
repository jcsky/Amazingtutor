class AddUserIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :user_id, :integer

    add_index :appointments, :user_id
  end
end
