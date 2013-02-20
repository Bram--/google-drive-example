module Google
  module Drive
    module APIClient
      SCOPES = [
        'https://www.googleapis.com/auth/drive.file',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ]

      def execute!(options)
        @client.execute!(options)
      end

      def authorization_uri
        authorization.authorization_uri(approval_prompt: :force, access_type: :offline)
      end

      def authorize!(code)
        authorization.code = code
        authorization.fetch_access_token!
      end

      def update_token!(auth_hash)
        authorization.update_token!(auth_hash)
        authorization.fetch_access_token! if expired?
      end

      def authorized?
        !! (authorization.refresh_token && authorization.access_token)
      end

      def authorization_hash
        { 'access_token'  => authorization.access_token,
          'refresh_token' => authorization.refresh_token,
          'expires_in'    => authorization.expires_in,
          'issued_at'     => authorization.issued_at
        }
      end

      private

      def drive
        @client.discovered_api('drive', 'v2')
      end

      def authorization
        @client.authorization
      end

      def expired?
        !! authorization.refresh_token && authorization.expired?
      end
    end
  end
end
