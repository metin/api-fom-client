require 'field_of_membership/utility/fom_connection'

module FieldOfMembership
  class Matches < Utility::FOMConnection
    def initialize(params = {})
      @params = params
    end

    def body
      @params.to_param
    end

    def http_method
      "post"
    end

    def endpoint
      "fom/matches.json"
    end
  end
end
