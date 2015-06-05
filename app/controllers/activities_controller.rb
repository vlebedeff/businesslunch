class ActivitiesController < ApplicationController
  authorize_resource

  def show
    @activities = Activity.order(created_at: :desc).page(params[:page])
  end
end
