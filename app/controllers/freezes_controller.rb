class FreezesController < ApplicationController
  def create
    Freeze.create
    redirect_to dashboard_path, notice: t('freeze.frozen')
  end

  def destroy
    Freeze.unfreeze
    redirect_to dashboard_path, notice: t('freeze.unfrozen')
  end
end
