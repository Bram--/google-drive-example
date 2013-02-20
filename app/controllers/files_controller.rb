class FilesController < ApplicationController
  def index
    @files = drive_client.get_file_listing.items
  end

  def new; end

  def create
    binding.pry
  end
end
