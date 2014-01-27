class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :question
      t.string :answer
      t.integer :difficulty_level

      t.timestamps
    end
  end
end
