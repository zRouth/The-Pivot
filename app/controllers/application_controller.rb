class ApplicationController < ActionController::Base
  # def current_user
  # end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
  def index
  end

  def menu
    @menu_items = MenuItem.all
  end
end
