class RemoveTwoColumnAndAddEvaluatedColumn < ActiveRecord::Migration
  def change
    remove_column :evaluations , :user_id
    remove_column :evaluations , :teacher_id

    add_column :evaluations, :evaluated_id, :integer

    add_index :evaluations, :evaluated_id
    add_index :evaluations, :evaluatable_id
  end
end
