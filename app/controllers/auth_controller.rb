class AuthController < ApplicationController
  skip_before_action :require_login, only: [:new_user_session, :user_session]

  def new_user_session
    render :login
  end

  def user_session
    begin
      session[:auth_headers] = { content_type: "application/json" }
      response = helpers.post_resource('/auth/sign_in', params)
      session[:auth_user] = JSON.parse(response.body, :symbolize_names => true)[:data]
      session[:auth_headers] = response.headers.without(:transfer_encoding)
      flash[:success] = "Successo."
      redirect_to(home_path)
    rescue Exception => e
      reset_session
      helpers.flash_errors(e.response)
      render :login
    end
  end

  def destroy_user_session
    begin
      response = helpers.get_resource('/auth/sign_out', params)
      reset_session
      redirect_to(action: :new_user_session)
    rescue Exception => e
      redirect_to(action: :new_user_session)
    end
  end
end
