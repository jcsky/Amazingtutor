class AddPaypal < ActiveRecord::Migration
  def change
    add_column :orders, :paid_at, :datetime
    add_column :orders, :paypal_status, :string
    add_column :orders, :paypal_transaction_id, :string
    add_column :orders, :paypal_params, :text
  end
end
