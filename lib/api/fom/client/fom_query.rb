module API
  module FOM
    module Client

      class Result < OpenStruct
      end

      class FOMQuery < Base

        def results
          fom_query_results.map do |result|
            Result.new(lender_id: result["lender_id"], reason: result["reason"])
          end
        end

        def result_lender_ids
          results.map &:lender_id
        end

        def self.end_point
          'fom_queries'
        end

        def self.create(criteria, query_type, lender_ids=[])
          request = Typhoeus::Request.new(resource_url, method: :post,
                                          body: { criteria: criteria, lender_ids: lender_ids,
                                                  query_type: query_type }.to_param)
          call request
        end

        def self.find(id)
          call Typhoeus::Request.new("#{resource_url}/#{id}", method: :get)
        end

      end
    end
  end
end
