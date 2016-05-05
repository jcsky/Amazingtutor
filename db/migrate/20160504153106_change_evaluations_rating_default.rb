class ChangeEvaluationsRatingDefault < ActiveRecord::Migration
  def change
    change_column_default :evaluations, :rating, 5
  end
end
