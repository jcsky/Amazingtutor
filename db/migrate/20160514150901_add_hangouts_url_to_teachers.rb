class AddHangoutsUrlToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :hangouts_url, :string
  end
end
