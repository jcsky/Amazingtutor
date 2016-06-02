class ChangeMajorFormatInEducations < ActiveRecord::Migration
    def up
    change_column :educations, :major, :text
  end

  def down
    change_column :educations, :major, :string
  end
end
