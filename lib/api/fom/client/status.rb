module API
  module FOM
    module Client

      class Status
        END_POINT = 'v2/status'

        attr_accessor :status_code

        def self.execute
          a_instance = new()
          a_instance.execute
          a_instance
        end

        def execute
          request = Typhoeus::Request.new("#{Configuration.config.host}/#{END_POINT}", method: :get)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          @status_code = response.code
        end

      end
    end
  end
end
