# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

problems =
[
  {
    question: "Capitalize the first letter of each word.",
    code: "words = ['paris', 'london', 'rome']",
    solution: %{words.map(&:capitalize)},
    answer: "['Paris', 'London', 'Rome']",
    difficulty_level: 1
  },

  {
    question: "Square each number in the numbers collection.",
    code: "numbers = [1, 2, 3, 4, 5]",
    solution: %{numbers.map {|n| n * n }},
    answer: "[1, 4, 9, 16, 25]",
    difficulty_level: 1
  },

  {
    question: "Set the first letter of each word to lower case.",
    code: "words = ['PARIS', 'LONDON', 'ROME']",
    solution: %{words.map {|c| c[0].downcase + c[1..-1] }},
    answer: "['pARIS', 'lONDON', 'rOME']",
    difficulty_level: 3
  }
]

problems.each do |problem|
  Problem.find_or_create_by(question: problem[:question]) do |p|
    p.code = problem[:code]
    p.solution = problem[:solution]
    p.answer = problem[:answer]
    p.difficulty_level = problem[:difficulty_level]
  end
end
