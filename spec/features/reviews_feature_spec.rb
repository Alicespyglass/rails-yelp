require 'rails_helper'

feature 'reviewing' do
  before {
    sign_up
    create_restaurant
  }

  scenario 'allows any user to leave a review using a form' do
    click_link 'Sign out'
    sign_up_second_user
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Reviews'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'so so'
  end
end
