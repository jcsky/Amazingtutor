class AddBelongsToEvaluatablePolymorphicToEvaluations < ActiveRecord::Migration
  def change
    add_belongs_to :evaluations, :evaluatable, polymorphic: true
  end
end
