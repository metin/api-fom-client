require 'spec_helper'

describe API::FOM::Client::Status do

  describe "#get" do
    subject { API::FOM::Client::Status.get }

    before do
      allow(RSAAuthority::Signer).to receive(:new) { double('auth', sign: true) }
      response = Typhoeus::Response.new(code: 200, body: "{\"message\":[\"Success\"]}")
      Typhoeus.stub(/beybun/).and_return(response)
    end


    it { expect(subject.status_code).to eq(200) }
  end

end
