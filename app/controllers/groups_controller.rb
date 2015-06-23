class GroupsController < ApplicationController
  authorize_resource

  def index
    @groups = Group.all
  end
end
