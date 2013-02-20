class AuthController < ApplicationController
  skip_before_filter :ensure_drive_is_autorized

  def auth
    if params[:code]
      drive_client.authorize!(params[:code])

      redirect_to root_url
    else
      render :not_authorized
    end
  end
end
