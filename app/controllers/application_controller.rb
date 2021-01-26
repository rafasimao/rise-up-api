class ApplicationController < ActionController::API
  def current_user
    if Rails.env == 'development'
      session[:user_id] ||= 1
    end
    @current_user ||= User.find(session[:user_id])
  end
end
