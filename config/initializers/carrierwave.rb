CarrierWave.configure do |config|
  if Rails.env.development? or Rails.env.test?
    config.storage = :file
    config.enable_processing = Rails.env.development?
  else
    config.fog_credentials = {
      config.provider               = 'AWS'
      config.aws_access_key_id      = ENV['AWS_ID']
      config.aws_secret_access_key  = ENV['AWS_SECRET']
    }
    config.fog_directory = ENV['AWS_BUCKET']
  end
end
