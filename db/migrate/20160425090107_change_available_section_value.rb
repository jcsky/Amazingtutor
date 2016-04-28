class ChangeAvailableSectionValue < ActiveRecord::Migration
  def change
    change_column :user_available_sections, :available_section, :integer, :default => 0
  end
end
