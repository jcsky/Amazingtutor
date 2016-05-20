class AddAppointmentUrlToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :appointment_url, :string
  end
end
