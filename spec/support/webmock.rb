RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-add").
      to_return(:status => 200, :body => "{\"id\": 1}", :headers => {})

    stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-update").
      to_return(:status => 200, :body => "", :headers => {})

    stub_request(:post, /http\:\/\/accounts\-fake\.nossascidades\.org\/users\/\d+\/segment_subscriptions\.json/).
      to_return(:status => 200, :body => "", :headers => {})

    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => {"client_id"=>"id", "client_secret"=>"secret", "code"=>"invalid", "grant_type"=>"authorization_code", "redirect_uri"=>"http://test.host/google_authorizations/grant"}).
      to_return(:status => 200, :body => "", :headers => {})

    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => {
        "client_id"=>"id",
        "client_secret"=>"secret",
        "code"=>"valid",
        "grant_type"=>"authorization_code",
        "redirect_uri"=>"http://test.host/google_authorizations/grant"
      }).
      to_return(
        :status => 200,
        :body => {
          access_token: "access_token",
          expires_in: 3920,
          token_type: "Bearer",
          refresh_token: "refresh_token",
          issued_at: Time.now
        }.to_json,
        :headers => {content_type: "application/json"}
      )

    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => {
        "client_id"=>"id",
        "client_secret"=>"secret",
        "code"=>"renew",
        "grant_type"=>"authorization_code",
        "redirect_uri"=>"http://test.host/google_authorizations/grant"
      }).
      to_return(
        :status => 200,
        :body => {
          access_token: "new_access_token",
          expires_in: 3920,
          token_type: "Bearer",
          refresh_token: "refresh_token",
          issued_at: Time.now
        }.to_json,
        :headers => {content_type: "application/json"}
      )

    stub_request(:get, "https://www.googleapis.com/discovery/v1/apis/drive/v2/rest").
      to_return(
        :status => 200,
        :body => File.open("#{Rails.root}/spec/support/google_drive_responses/api.json").read,
        :headers => {content_type: "application/json"}
      )

    stub_request(:post, "https://www.googleapis.com/drive/v2/files/GOOGLE_DRIVE_FILE_ID/copy").
      to_return(
        :status => 200,
        :body => File.open("#{Rails.root}/spec/support/google_drive_responses/copy_file.json").read,
        :headers => {content_type: "application/json"}
      )

    stub_request(:post, /https\:\/\/www\.googleapis\.com\/drive\/v2\/files\/(.)+\/permissions/).
      to_return(
        :status => 200,
        :body => File.open("#{Rails.root}/spec/support/google_drive_responses/insert_permission.json").read,
        :headers => {content_type: "application/json"}
      )
  end
end
