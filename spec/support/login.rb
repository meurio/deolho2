def login user
  visit root_path(login: true)
  fill_in 'username', with: user.email
  fill_in 'password', with: 'any password'
  click_button 'Login'
end
