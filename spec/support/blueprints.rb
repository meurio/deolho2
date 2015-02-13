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
  user
  google_drive_embed { '<iframe src="https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/pub?embedded=true"></iframe>' }
  google_drive_url { 'https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/edit' }
  closes_for_contribution_at { Time.now.next_week }
  image { File.open("#{Rails.root}/spec/fixtures/files/project.jpg") }
end

Project.blueprint(:with_legislative_fields_changed) do
  legislative_processing { "My project processing" }
  legislative_chamber { "ALERJ" }
end

Project.blueprint(:with_custom_facebook_share_content) do
  facebook_share_title { "Custom title" }
  facebook_share_description { "Custom description" }
  facebook_share_image { File.open("#{Rails.root}/spec/fixtures/files/project.jpg") }
end

Project.blueprint(:with_custom_email) do
  email_to_contributor { "Custom email to contributor" }
  email_to_signer { "Custom email to signer" }
end

Project.blueprint(:with_custom_twitter_message) do
  twitter_share_message { "Custom Twitter message" }
end

Project.blueprint(:with_custom_taf_message) do
  taf_message { "Custom TAF message" }
end

Signature.blueprint do
  user
  project
end

Contribution.blueprint do
  user
  project
end

Adoption.blueprint do
  user
  project
end

Category.blueprint do
  name { "Category #{sn}" }
end

Organization.blueprint do
  city { "City #{sn}" }
end
