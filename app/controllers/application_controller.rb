class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include UsersHelper

  before_action :authenticate_user!, :set_online

  protected
  def set_online
    if !!current_user
      Myapp::Redis.new.set("user_online_#{current_user.id}", nil, ex: 5*60)
    end
  end
end
