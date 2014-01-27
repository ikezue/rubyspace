# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :problem do
    question "Concatenate the strings: 'cow' and 'boy'"
    answer 'cowboy'
    solution "'cow' + 'boy'"
    difficulty_level 1
  end
end
