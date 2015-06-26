class ActivitiesController < ApplicationController
  authorize_resource

  def show
    @activities = Activity.where(group: current_group)
                  .order(created_at: :desc).page(params[:page])
  end
end
