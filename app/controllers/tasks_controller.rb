class TasksController < ApplicationController

  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create, :update, :destroy]

  def index
    respond_to do |format|
      format.html {}
      format.json {
        my_tasks = Task.my_tasks(current_user.id)
        other_tasks = Task.other_tasks(current_user.id)
        render json: { my_tasks: my_tasks.as_json({includes: [:user]}), other_tasks: other_tasks.as_json({includes: [:user]}) }
      }
    end
  end

  def create
    task = Task.new(tasks_params)
    if task.save
      render json: {message: "New task created"}
    else
      render json: {message: "Hey, we ran into an error. Check your task", errors: task.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(tasks_params)
      render json: task
    else
      render json: { message: "Hey, we ran into an error. Check your task", errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def tasks_params
      params.permit(:title, :description)
    end

end