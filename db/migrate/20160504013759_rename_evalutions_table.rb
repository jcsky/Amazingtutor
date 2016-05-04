class RenameEvalutionsTable < ActiveRecord::Migration
  def change
    rename_table :evalutions, :evaluations
  end
end
