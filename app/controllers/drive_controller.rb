class DriveController < ApplicationController
  def index
    @metadata = drive_client.get_drive_metadata
  end
end
