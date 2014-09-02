require 'spec_helper'

describe API::FOM::Client::Status do
  subject { API::FOM::Client::Status.new }

  describe "#execute" do
    before do
      allow(RSAAuthority::Signer).to receive(:new) { double('auth', sign: true) }
      response = Typhoeus::Response.new(code: 200, body: "[]")
      Typhoeus.stub(/beybun/).and_return(response)
      subject.execute
    end


    it { expect(subject.status_code).to eq(200) }
  end

end
