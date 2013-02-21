class FilesController < ApplicationController
  def index
    @files = drive_client.get_file_listing.items
  end

  def new; end

  def create
    file, descr = params.slice(:file, :description).values
    drive_client.upload_file!(file, descr)

    redirect_to files_url
  end

  def destroy
    drive_client.delete_file!(params[:id])

    redirect_to files_url
  end
end
