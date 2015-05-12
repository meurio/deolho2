RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-add").
      to_return(:status => 200, :body => "{\"id\": 1}", :headers => {})

    stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-update").
       to_return(:status => 200, :body => "", :headers => {})

    stub_request(:post, /http\:\/\/accounts\-fake\.nossascidades\.org\/users\/\d+\/segment_subscriptions\.json/).
      to_return(:status => 200, :body => "", :headers => {})
  end
end
