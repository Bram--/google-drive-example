require 'google/api_client/client_secrets'

module Google
  module Drive
    class Client
      include Google::Drive::APIClient

      def initialize(credentials)
        @client = begin
          client = Google::APIClient.new

          client.authorization.client_id     = credentials.client_id
          client.authorization.client_secret = credentials.client_secret
          client.authorization.redirect_uri  = credentials.redirect_uris.first
          client.authorization.scope         = SCOPES
          client
        end
      end

      # Gets the information about the current user along with Drive API settings.
      # https://developers.google.com/drive/v2/reference/about/get
      def get_drive_metadata
        execute!(drive.about.get).data
      end

      # Lists the user's files
      # https://developers.google.com/drive/v2/reference/files/list
      def get_file_listing
        execute!(drive.files.list).data
      end

      # Insert a new file.
      # https://developers.google.com/drive/v2/reference/files/insert
      def upload_file!(file, description)
        execute!(
          api_method:  drive.files.insert,
          body_object: file_description(file, description),
          media:       Google::APIClient::UploadIO.new(file, file.content_type),
          parameters:  { uploadType: 'multipart', alt: 'json'})
      end

      # Permanently deletes a file by ID. Skips the trash.
      # https://developers.google.com/drive/v2/reference/files/delete
      def delete_file!(file_id)
        execute!(api_method: drive.files.delete, parameters: { fileId: file_id })
      end

      private
      def file_description(file, description)
        { title:       file.original_filename,
          description: description,
          mimeType:    file.content_type }
      end
    end
  end
end
