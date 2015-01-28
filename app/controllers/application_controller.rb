class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  # Call Rack::FakeCAS to handle the login when it's
  # not the production environment
  before_filter do
    if !Rails.env.production? && params[:login]
      render status: 401, nothing: true
    end
  end

  check_authorization

  def current_user
    if session['cas']
      @current_user ||= User.find_by(email: session['cas']['user'])
    end
  end
end
