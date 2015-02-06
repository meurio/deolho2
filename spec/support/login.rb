def login user, strategy
  if strategy == "feature"
    visit root_path(login: true)
    fill_in 'username', with: user.email
    fill_in 'password', with: 'any password'
    click_button 'Login'
  elsif strategy == "controller"
    session['cas'] = { 'user' => user.email }
  else
    raise "Unknown login strategy #{strategy}"
  end
end
