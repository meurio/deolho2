require 'machinist/active_record'

User.blueprint do
  email { "test#{sn}@trashmail.com" }
  first_name { "Kyle" }
  last_name { "Craine" }
end

Project.blueprint do
  title { "Project #{sn}" }
  abstract { "My project abstract" }
  category
  organization
  google_drive_embed { '<iframe src="https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/pub?embedded=true"></iframe>' }
  google_drive_url { 'https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/edit' }
end

Signature.blueprint do
  user
  project
end

Category.blueprint do
  name { "Category #{sn}" }
end

Organization.blueprint do
  city { "City #{sn}" }
end
