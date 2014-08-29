require 'spec_helper'

describe API::FOM::Client::Query do
  subject { API::FOM::Client::Query.new({state_codes: ["NJ"]}, :fom, []) }

  describe "#execute" do
    before do
      API::FOM::Client::Configuration.configure do |config|
        config.private_key = 'my/private/key.pem'
        config.client_id = 'my-ca23dse'
        config.host = 'http://api.beybun.dev:3000'
      end

      allow(RSAAuthority::Signer).to receive(:new) { double('auth', sign: true) }
      response = Typhoeus::Response.new(code: 200, body: "{\"id\":13,\"fom_query_results\":[{\"lender_id\":118,\"reason\":\"I live in NJ\"}]}")
      Typhoeus.stub(/beybun/).and_return(response)
      subject.execute
    end


    it { expect(subject.query_id).to eq(13) }
    it { expect(subject.results).to have(1).results }
  end

end
