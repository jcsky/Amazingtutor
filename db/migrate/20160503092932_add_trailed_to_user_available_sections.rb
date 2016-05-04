class AddTrailedToUserAvailableSections < ActiveRecord::Migration
  def change
    add_column :user_available_sections, :trailed, :boolean,  :default => false
  end
end
