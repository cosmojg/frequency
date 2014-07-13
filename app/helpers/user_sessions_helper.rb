module UserSessionsHelper
  def logged_in?
    !!current_user
  end
end
