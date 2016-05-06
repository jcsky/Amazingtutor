class AddTeacherCheck < ActiveRecord::Migration
  def change
    add_column :teachers , :check ,:string
  end
end
