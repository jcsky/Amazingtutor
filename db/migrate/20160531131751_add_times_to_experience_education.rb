class AddTimesToExperienceEducation < ActiveRecord::Migration
  def change
    add_column :experiences, :start, :datetime
    add_column :educations, :start, :datetime
    add_column :experiences, :end, :datetime
    add_column :educations, :end, :datetime
  end
end
