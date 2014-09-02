module API
  module FOM
    module Client

      class Result < OpenStruct
      end

      class FOMQuery < OpenStruct
        END_POINT = 'fom_queries'

        def self.load_json(json_data)
          instance = new(JSON.parse(json_data))
        end

        def results
          fom_query_results.map do |result|
            Result.new(lender_id: result["lender_id"], reason: result["reason"])
          end
        end

        def result_lender_ids
          results.map &:lender_id
        end

        def self.resource_url
          "#{Configuration.config.host}/#{Configuration.config.version}/#{END_POINT}"
        end

        def self.create(criteria, query_type, lender_ids=[])
          request = Typhoeus::Request.new(resource_url, method: :post,
                                          body: { criteria: criteria, lender_ids: lender_ids,
                                                  query_type: query_type }.to_param)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          FOMQuery.load_json(response.body)
        end

        def self.find(id)
          request = Typhoeus::Request.new("#{resource_url}/#{id}", method: :get)
          RSAAuthority::Signer.new(request, Configuration.config.private_key, Configuration.config.client_id).sign
          response = request.run
          debugger
          FOMQuery.load_json(response.body)
        end

      end
    end
  end
end
