module API
  module FOM
    module Client

      class Base < OpenStruct

        def self.load(json_data, status_code)
          new(JSON.parse(json_data).merge(status_code: status_code))
        end

        def self.resource_url
          "#{Configuration.config.host}/#{Configuration.config.version}/#{end_point}"
        end

        def self.call(request)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          load(response.body, response.code)
        end

      end
    end
  end
end
