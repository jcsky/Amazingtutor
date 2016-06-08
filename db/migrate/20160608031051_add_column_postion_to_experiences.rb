class AddColumnPostionToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :position, :string
  end
end
