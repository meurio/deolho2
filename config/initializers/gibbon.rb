if Rails.env.development? || Rails.env.test?
  Gibbon::API.api_key = "fake"
end
