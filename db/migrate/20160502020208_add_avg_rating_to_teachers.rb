class AddAvgRatingToTeachers < ActiveRecord::Migration
  def change
     add_column :teachers, :avg_rating, :integer, default: 0
  end
end
