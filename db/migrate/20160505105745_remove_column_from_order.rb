class RemoveColumnFromOrder < ActiveRecord::Migration
  def change
    
    remove_column :orders, :paypal_payment_id, :string
    remove_column :orders, :paypal_state, :string
    remove_column :orders, :paypal_create_time, :datetime
    remove_column :orders, :paypal_update_time, :datetime
    remove_column :orders, :paypal_approval_url, :string
    remove_column :orders, :paypal_execute_url, :string
    remove_column :orders, :paypal_error, :text
    remove_column :orders, :paypal_payer_id, :string
    remove_column :orders, :paypal_return_at, :datetime

  end
end
