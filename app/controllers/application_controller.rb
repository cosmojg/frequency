class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_variables
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    unless defined?(@current_user_session)
      flash[:error] = exception.message
      redirect_to login_url
    else
      flash[:error] = exception.message
      redirect_to :overview
    end
  end

  private

  def initialize_variables
    @pictures = Picture.order("created_at desc").limit(7)
  end

  def require_login
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |user_name, password|
        # Change these to username and password required
        user_name == "frodo" && password == "ohhello"
      end
    end
  end

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.record
  end

end
