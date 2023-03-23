class ApplicationController < ActionController::API
  include ActionController::Cookies

  def app_response(message: "success", status: 200, data: nil)
    render json: { message: message, data: data }, status: status
  end

  #store user_id in session
  def save_user(id)
    session[:uid] = id
    session[:expiry] = 6.hours.from_now
  end

  #delete user_id in session
  def remove_user
    session.delete(:uid)
    session[:expiry] = Time.now
  end

  #check for session expiry
  def session_expired?
    #if session[:expiry]
    session[:expiry] ||= Time.now
    time_diff = (Time.parse(session[:expiry]) - Time.now).to_i
    unless time_diff > 0
      app_response(message: "failed", status: 401, data: { info: "Your session has expired. Please login again to continue" })
    end
  end

  #get logged in user_id
  def user
    User.find(session[:uid].to_i)
  end
end
