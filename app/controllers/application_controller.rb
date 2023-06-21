class ApplicationController < ActionController::Base
  include WillPaginate::ViewHelpers
  helper_method :current_user

  def current_user
    @current_user ||= User.first
  end
end
