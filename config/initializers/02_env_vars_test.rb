if Rails.env.test?
  ENV["GOOGLE_CLIENT_ID"] = "id"
  ENV["GOOGLE_CLIENT_SECRET"] = "secret"
  ENV["GOOGLE_DRIVE_FILE_ID"] = "GOOGLE_DRIVE_FILE_ID"
end
