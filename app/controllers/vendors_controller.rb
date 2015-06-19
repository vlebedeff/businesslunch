class VendorsController < ApplicationController
  authorize_resource
  before_action :find_vendor, only: [:edit, :update]

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

  def edit
  end

  def update
    if @vendor.update_attributes safe_params
      redirect_to vendors_path,
                  notice: t(:updated_successfully, entity: 'Vendor')
    else
      render :edit
    end
  end

  private

  def safe_params
    params.require(:vendor).permit(:name)
  end

  def find_vendor
    @vendor = Vendor.find params[:id]
  end
end
