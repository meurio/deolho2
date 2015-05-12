class SegmentSubscription
  def self.create args
    HTTParty.post(
      "#{ENV["ACCOUNTS_HOST"]}/users/#{args[:user_id]}/segment_subscriptions.json",
      body: {
        token: ENV["ACCOUNTS_API_TOKEN"],
        segment_subscription: { segment_id: args[:segment_id] }
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
