class AddStartEndToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :start, :datetime
    add_column :appointments, :end, :datetime
  end
end
