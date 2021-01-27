
class AreasController < ApplicationController
  before_action :set_area, only: [:show, :update, :destroy]

  def index
    render json: user_areas_with_progress, status: :ok
  end

  def create
    area = current_user.areas.create!(area_params)
    area.create_progress
    render json: area.attributes_with_progress, status: :ok
  end

  def show
    render json: @area.attributes_with_progress, status: :ok
  end

  def update
    @area.update!(area_params)
    render json: @area.attributes_with_progress, status: :ok
  end

  def destroy
    @area.destroy!
    render json: @area.attributes_with_progress, status: :ok
  end

  private

  def area_params
    params.require(:area).permit(:title, :area_id)
  end

  def set_area
    @area = current_user.areas.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {error: {message: "#{e.model} couldnt be found"}}, status: :not_found
  end

  def user_areas_with_progress
    current_user.areas.includes(:progress).map { |area| area.attributes_with_progress }
  end
end
