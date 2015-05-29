require "rails_helper"

RSpec.describe GoogleDrive, :type => :helper do
  let(:client_id) { "client_id" }
  let(:client_secret) { "client_secret" }
  let(:scope) { "https://www.googleapis.com/auth/drive" }

  before do
    GoogleDrive.config do |config|
      config.api_client_template = Google::APIClient.new
      config.api_client_template.authorization.client_id = client_id
      config.api_client_template.authorization.client_secret = client_secret
      config.api_client_template.authorization.scope = scope
    end
  end

  describe ".config" do
    it "should set the Google::APIClient" do
      auth = GoogleDrive.api_client_template.authorization
      expect(auth.client_id).to be_eql(client_id)
      expect(auth.client_secret).to be_eql(client_secret)
      expect(auth.scope).to be_eql([scope])
    end
  end

  describe ".api" do
    it "should return a Google::APIClient::API instance" do
      expect(GoogleDrive.api).to be_instance_of(Google::APIClient::API)
    end
  end

  describe ".generate_api_client" do
    it "should return an Google::APIClient with access token" do
      access_token = "123"
      api_client = GoogleDrive.generate_api_client access_token
      expect(api_client.authorization.access_token).to be_eql(access_token)
    end
  end

  describe ".generate_authorization" do
    it "should return an Signet::OAuth2::Client instace" do
      auth = GoogleDrive.generate_authorization
      expect(auth).to be_instance_of(Signet::OAuth2::Client)
    end
  end

  describe ".copy_file" do
    it "should return the copied file" do
      file = GoogleDrive.copy_file(
        file_id: ENV["GOOGLE_DRIVE_FILE_ID"],
        title: "My Title",
        access_token: "123"
      )

      data = file.data
      expect(data["kind"]).to be_eql("drive#file")
    end
  end

  describe ".insert_permission" do
    it "should return the inserted permission" do
      permission = GoogleDrive.insert_permission(
        file_id: "123",
        role: "reader",
        type: "anyone",
        additional_roles: ["commenter"],
        access_token: "123"
      )

      data = permission.data
      expect(data["kind"]).to be_eql("drive#permission")
    end
  end
end
