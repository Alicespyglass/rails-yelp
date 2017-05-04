require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have beed added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    scenario 'display restaurants' do
      sign_up
      create_restaurant
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

    scenario 'cannot create restaurant unless signed in' do
      visit '/'
      click_link 'Add a restaurant'
      expect(current_path).to eq "/users/sign_in"
    end
  end

  context 'viewing restaurants' do
      scenario 'lets any user view a restaurant' do
        sign_up
        create_restaurant
        click_link 'Sign out'
        sign_up_second_user
        click_link 'KFC'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
      end
  end

  context 'editing restaurants' do
    before {
      sign_up
      create_restaurant
    }

    scenario 'let the owner edit a restaurant' do
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end

    scenario 'only if they created it' do
      click_link 'Sign out'
      sign_up_second_user
      click_link 'Edit KFC'
      expect(current_path).to eq '/'
      expect(page).to have_content 'Only owner can make changes to this restaurant'
    end
  end

  context 'deleting restaurants' do
    before {
      sign_up
      create_restaurant
    }

    scenario 'remove a restaurant when a user clicks a delete link' do
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'only if they created it' do
      click_link 'Sign out'
      sign_up_second_user
      click_link 'Delete KFC'
      expect(current_path).to eq '/'
      expect(page).to have_content 'Only owner can make changes to this restaurant'
    end
  end
end
