
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    render json: current_user.tasks, status: :ok
  end

  def create
    task = current_user.tasks.create!(task_params)
    render json: task, status: :ok
  end

  def show
    render json: @task, status: :ok
  end

  def update
    @task.update!(task_params)
    render json: @task, status: :ok
  end

  def destroy
    @task.destroy!
    render json: @task, status: :ok
  end

  private

  def task_params
    params.require(:task).permit(
      :title, :done, :value_points, :difficulty_points, :experience_points, :area_id, :project_id
    )
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {error: {message: "#{e.model} couldnt be found"}}, status: :not_found
  end
end
