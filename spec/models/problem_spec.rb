require 'spec_helper'

describe Problem do
  it "is valid with a question, an answer, and a difficulty level" do
    expect(build :problem).to be_valid
  end

  it "is invalid without a question" do
    problem = build(:problem, question: nil)
    expect(problem).to have(1).error_on(:question)
  end

  it "is invalid without an answer" do
    problem = build(:problem, answer: nil)
    expect(problem).to have(1).error_on(:answer)
  end
end
