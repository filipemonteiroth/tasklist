class TasksController < ApplicationController

  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]

  def index
    respond_to do |format|
      format.html {}
      format.json {
        tasks = Task.all
        render json: tasks.as_json({includes: [:user]})
      }
    end
  end

  def create
    task = Task.new(tasks_params)
    if task.save
      render json: {message: "New task created"}
    else
      render json: {message: "Hey, we ran into an error. Check your task", errors: task.errors.full_messages}
    end
  end

  private
    def tasks_params
      params.permit(:title, :description)
    end

end