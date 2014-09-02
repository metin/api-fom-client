require 'spec_helper'

describe API::FOM::Client::FOMQuery do
  subject { API::FOM::Client::FOMQuery.create({state_codes: ["NJ"]}, :fom, []) }
  before do
    API::FOM::Client::Configuration.configure do |config|
      config.private_key = 'my/private/key.pem'
      config.client_id = 'my-ca23dse'
      config.host = 'http://api.beybun.dev:3000/fom'
      config.version = 'v2'
    end

    allow(RSAAuthority::Signer).to receive(:new) { double('auth', sign: true) }
  end

  describe "#create" do
    before do
      response = Typhoeus::Response.new(code: 200, body: "{\"id\":13,\"fom_query_results\":[{\"lender_id\":118,\"reason\":\"I live in NJ\"}]}")
      Typhoeus.stub(/beybun/).and_return(response)
      subject.execute
    end


    it { expect(subject.id).to eq(13) }
    it { expect(subject.results).to have(1).results }
  end

  describe "#find" do
    before do
      response = Typhoeus::Response.new(code: 200, body: "{\"id\":17,\"uri\":\"fom_queries/17\",\"fom_query_results\":[{\"lender_id\":118,\"reason\":\"I live in NJ\"}]}")
      Typhoeus.stub(/beybun/).and_return(response)
      subject.execute
    end

    it { expect(subject.id).to eq(17) }
    it { expect(subject.results).to have(1).results }
  end

end
