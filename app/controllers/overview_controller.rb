class OverviewController < ApplicationController

  def index
    @users_online = User.where("last_request_at >= ?", 30.minutes.ago).order("last_request_at desc")
    @latest_blogs = Blog.limit(3).order("created_at desc")
    @latest_activity = Activity.includes(:user).order("created_at desc").limit(12)

    # Oh god what a terrible solution. Will come up with a better one
    @first_blog = @latest_blogs.first
    @second_blog = @latest_blogs[-2]
    @last_blog = @latest_blogs.last
  end

end