module API
  module FOM
    module Client

      class Status < Base
        def self.end_point
          'status'
        end

        def self.get
          call Typhoeus::Request.new(resource_url, method: :get)
        end
      end
    end
  end
end
