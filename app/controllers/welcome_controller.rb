class WelcomeController < ApplicationController
  def index
  end

  def disable_announcement
    cookies[:"#{params[:announcement]}_announcement_disabled"] = true
  end
end
