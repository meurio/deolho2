if Rails.env.development? || Rails.env.test?
  ENV["ACCOUNTS_HOST"] = "http://accounts-fake.nossascidades.org"
end
