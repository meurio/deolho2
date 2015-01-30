require 'machinist/active_record'

User.blueprint do
  email { "test#{sn}@trashmail.com" }
  first_name { "Kyle" }
  last_name { "Craine" }
end

Project.blueprint do
end

Signature.blueprint do
  user
  project
end
