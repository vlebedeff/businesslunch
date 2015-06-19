class VendorsController < ApplicationController
  authorize_resource

  def index
    @vendors = Vendor.all
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new safe_params
    if @vendor.save
      redirect_to vendors_path,
                  notice: t(:created_successfully, entity: 'Vendor')
    else
      render :new
    end
  end

  private

  def safe_params
    params.require(:vendor).permit(:name)
  end
end
