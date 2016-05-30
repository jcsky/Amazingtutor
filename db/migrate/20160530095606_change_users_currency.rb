class ChangeUsersCurrency < ActiveRecord::Migration
  def change
    change_column :users ,:currency, :string, :default => 'USD'
  end
end
