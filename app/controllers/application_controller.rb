class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def get_current_user_id
    helpers.get_attribute_value_from(session[:auth_user], 'id')
  end

  private
  def require_login
    unless session.has_key?(:auth_user)
      redirect_to(controller: 'auth', action: 'new_user_session')
    end
  end
end
