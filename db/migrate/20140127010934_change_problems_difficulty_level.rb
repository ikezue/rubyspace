class ChangeProblemsDifficultyLevel < ActiveRecord::Migration
  def change
    change_column :problems, :difficulty_level, :integer, default: 1
  end
end
