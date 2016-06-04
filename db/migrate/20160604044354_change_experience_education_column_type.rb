class ChangeExperienceEducationColumnType < ActiveRecord::Migration
  def change
    change_column :experiences ,:start, :string
    change_column :experiences ,:end, :string
    change_column :educations ,:start, :string
    change_column :educations ,:end, :string
  end
end
