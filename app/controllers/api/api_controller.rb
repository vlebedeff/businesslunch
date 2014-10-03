module Api
  class ApiController < ActionController::Metal
    [
      AbstractController::Rendering,

      ActionController::HideActions,
      ActionView::Layouts,
      ActionController::Rendering,
      ActionController::Renderers::All,
      ActionController::ConditionalGet,
      ActionController::Caching,
      ActionController::MimeResponds,
      ActionController::ImplicitRender,
      ActionController::StrongParameters,

      ActionController::RequestForgeryProtection,
      ActionController::ForceSSL,

      # Append rescue at the bottom to wrap as much as possible.
      ActionController::Rescue,

      # Add instrumentations hooks at the bottom, to ensure they instrument
      # all the methods properly.
      ActionController::Instrumentation,

      # Params wrapper should come before instrumentation so they are
      # properly showed in logs
      ActionController::ParamsWrapper,

    ].each do |mod|
      include mod
    end

    # need make ApiController aware of the routes
    include Rails.application.routes.url_helpers

    # tell controller where to look for templates
    append_view_path "#{Rails.root}/app/views"

    wrap_parameters format: [:json]

    protect_from_forgery

    respond_to :json

    rescue_from ActiveRecord::RecordNotFound do
      respond_to do |format|
        format.any  { head :not_found }
      end
    end
  end
end
