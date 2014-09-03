module FieldOfMembership::Utility
  module RSAAuth
    include ConnectionConfiguration

    def fetch
      RSAAuthority::Signer.new(self, private_key, client_id).sign
      super
    end

    private

    def sign(signature, client_id)
      headers.store('X-Signature', signature)
      headers.store('X-Client-ID', client_id)
    end

    def headers
      @headers ||= super
    end

    def data
      timestamp
    end

    def timestamp
      Time.now.utc.to_i.to_s
    end

    def private_key
      self.class.configuration.private_key
    end

    def client_id
      self.class.configuration.client_id
    end

    def on_success
      ReasonsForMembership.new(JSON.parse(@response.body))
    end
    
  end
end
