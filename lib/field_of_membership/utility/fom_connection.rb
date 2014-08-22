require 'service_connections/http_service_connection'

module FieldOfMembership::Utility
  class FOMConnection < HTTPServiceConnection
    include RSAAuth
  end
end
