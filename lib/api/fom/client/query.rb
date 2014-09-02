module API
  module FOM
    module Client

      class Result < OpenStruct
      end

      class Query
        END_POINT = 'fom_queries'
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
          request = Typhoeus::Request.new("#{Configuration.config.host}/#{Configuration.config.version}/#{END_POINT}",
                                          method: :post,
                                          body: { criteria: criteria, lender_ids: lender_ids,
                                                  query_type: query_type }.to_param)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          @results = JSON.parse(response.body)
        end

        def results
          @results["fom_query_results"].map do |result|
            Result.new(lender_id: result["lender_id"], reason: result["reason"])
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
