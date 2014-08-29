module API
  module FOM
    module Client

      class Result
        attr_accessor :lender_id, :reason

        def initialize(lender_id, reason)
          @lender_id = lender_id
          @reason = reason
        end
      end

      class Query
        attr_accessor :lender_ids, :criteria, :query_type

        def initialize(criteria, query_type, lender_ids=[])
          @criteria = criteria
          @lender_ids = lender_ids
          @query_type = query_type
        end

        def self.execute(*args)
          a_instance = new(*args)
          a_instance.execute
          a_instance
        end

        def execute
          target_lender_ids =  (1..400).to_a
          request = Typhoeus::Request.new("#{Configuration.config.host}/fom/v2/fom_queries",
                                          method: :post, body: { criteria: criteria,
                                                                 lender_ids: lender_ids,
                                                                 query_type: query_type }.to_param)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          @results = JSON.parse(response.body)
        end

        def results
          @results["fom_query_results"].reduce([]) do |all, result|
            all << Result.new(result["lender_id"], result["reason"])
          end
        end

        def query_id
          @results["id"]
        end

        def result_lender_ids
          results.map &:lender_id
        end

      end
    end
  end
end
