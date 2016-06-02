class ChangeDecriptionFormatInCompanyName < ActiveRecord::Migration
    def up
    change_column :experiences, :description, :text
  end

  def down
    change_column :experiences, :description, :string
  end
end
