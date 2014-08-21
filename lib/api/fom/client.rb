require "typhoeus"
require "rsa_authority"
require "json"
require 'active_support'
require 'active_support/core_ext'

require "api/fom/client/version"
require "api/fom/client/query"

module API
  module FOM
    module Client

      class Configuration
        include ActiveSupport::Configurable

      end
    end
  end
end
