class FreezesController < ApplicationController
  def create
    Freeze.create
    redirect_to dashboard_path, notice: t('freeze.frozen')
  end
end
