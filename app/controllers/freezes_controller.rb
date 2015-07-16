class FreezesController < ApplicationController
  authorize_resource class: false

  def create
    Freeze.create group: current_group
    redirect_to dashboard_path, notice: t('freeze.frozen')
  end

  def destroy
    Freeze.unfreeze(current_group)
    redirect_to dashboard_path, notice: t('freeze.unfrozen')
  end
end
