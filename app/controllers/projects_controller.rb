
class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    render json: user_projects_with_progress, status: :ok
  end

  def create
    project = current_user.projects.create!(project_params)
    project.create_progress
    render json: project.attributes_with_progress, status: :ok
  end

  def show
    render json: @project.attributes_with_progress, status: :ok
  end

  def update
    @project.update!(project_params)
    render json: @project.attributes_with_progress, status: :ok
  end

  def destroy
    @project.destroy!
    render json: @project.attributes_with_progress, status: :ok
  end

  private

  def project_params
    params.require(:project).permit(:title, :project_id)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {error: {message: "#{e.model} couldnt be found"}}, status: :not_found
  end

  def user_projects_with_progress
    current_user.projects.includes(:progress).map { |project| project.attributes_with_progress }
  end
end
