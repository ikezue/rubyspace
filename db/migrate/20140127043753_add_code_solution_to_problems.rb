class AddCodeSolutionToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :code, :string
    add_column :problems, :solution, :string
  end
end
