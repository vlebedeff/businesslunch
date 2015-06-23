class GroupsController < ApplicationController
  authorize_resource

  def index
    @groups = Group.all
  end

  def join
    @group = Group.find params[:id]
    if current_user.join_group @group
      flash[:notice] = t('groups.successfully_joined', group: @group.name)
    end
    redirect_to root_path
  end
end
