class TasksController < ApplicationController

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html {}
      format.json {
        tasks = Task.all
        render json: tasks.as_json({includes: [:user]})
      }
    end
  end

end