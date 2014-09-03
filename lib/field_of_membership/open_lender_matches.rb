module FOMInterface

  class OpenLenderMatches < Utility::FOMConnections
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
      "fom/open_lender_matches.json"
    end
  end

end