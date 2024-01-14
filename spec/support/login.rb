def login_as(user)
  visit admin_root_path

  fill_in "Email", with: user.email
  fill_in "Password", with: "changeme"
  click_button "Submit"
end