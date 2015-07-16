class GroupsController < ApplicationController
  authorize_resource
  before_action :find_group, only: [:join, :leave, :make_current]

  def index
    @groups = Group.all
  end

  def join
    if current_user.join_group @group
      flash[:notice] = t('groups.successfully_joined', group: @group.name)
    end
    redirect_to root_path
  end

  def leave
    if current_user.leave_group @group
      flash[:notice] = t('groups.successfully_left', group: @group.name)
    end
    redirect_to root_path
  end

  def make_current
    current_user.change_current_group_to @group
    redirect_to root_path,
                notice: t('groups.successfully_changed', group: @group.name)
  end

  private

  def find_group
    @group = Group.find params[:id]
  end
end
