def sign_up(email: 'test@mctestface.com',
            password: '123456',
            password_confirmation: '123456')
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end

def sign_up_second_user(email: 'roi@makers.com',
                        password: '123456',
                        password_confirmation: '123456')
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end

def create_restaurant(name: 'KFC')
  visit '/'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end
