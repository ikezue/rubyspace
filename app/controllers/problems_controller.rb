class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
    respond_to do |format|
      format.html
      format.json { render json: @problems }
    end
  end
end
