class ChangeTeachersFeeColumnsType < ActiveRecord::Migration
  def change
    change_column :teachers ,:one_fee, :integer
    change_column :teachers ,:five_fee, :integer
    change_column :teachers ,:ten_fee, :integer
  end
end
