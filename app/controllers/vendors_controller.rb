class VendorsController < ApplicationController
  authorize_resource

  def index
    @vendors = Vendor.all
  end
end
