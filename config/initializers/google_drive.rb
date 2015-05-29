GoogleDrive.config do |config|
  config.api_client_template = Google::APIClient.new
  config.api_client_template.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
  config.api_client_template.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
  config.api_client_template.authorization.scope = 'https://www.googleapis.com/auth/drive'
end
