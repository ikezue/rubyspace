class ProblemsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@problems = Problem.all)
  end
end
