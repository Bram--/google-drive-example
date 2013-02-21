class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_token!, :ensure_drive_is_autorized
  after_filter :update_token_data

  def update_token!
    auth_hash_keys = drive_client.authorization_hash.keys
    session_data   = session.to_hash.slice *auth_hash_keys

    drive_client.update_token! session_data
  rescue => e
    redirect_to auth_url
  end

  def update_token_data
    session.merge!(drive_client.authorization_hash)
  end

  def ensure_drive_is_autorized
    return if drive_client.authorized?

    redirect_to auth_url
  end

  def drive_client
    @client ||= Google::Drive::Client.new(::Settings.credentials)
  end
  helper_method :drive_client

  def auth_url
    drive_client.authorization_uri.to_s
  end
  helper_method :auth_url
end
