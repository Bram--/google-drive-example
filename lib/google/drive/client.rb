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

      def get_drive_metadata
        execute!(drive.about.get).data
      end

      def get_file_listing
        execute!(drive.files.list).data
      end

      def upload_file!(file)
        execute!(drive.files.list).data
      end
    end
  end
end
