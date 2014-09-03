module FOMInterface

  class MatchesWithReason < Utility::FOMConnections
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
      "fom/matches_with_reason.json"
    end
  end

end