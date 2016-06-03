class ChangeUserAdminName < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :admin_by_lululala
  end
end
