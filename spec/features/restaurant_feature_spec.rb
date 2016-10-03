require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurant has been added' do
    scenario '' do
      Restaurant.create(name: "Burger King")
      visit '/restaurants'
      expect(page).to have_content("Burger King")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
      Restaurant.create(name: "KFC", rating: 4, address: "London", description: "chicken")
      Restaurant.create(name: "Burger King", rating: 3, address: "Bristol", description: "Burger")
      visit "/restaurants"
      expect(page).to have_content("KFC")
      expect(page).to have_content("Burger King")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "user can add a new restaurant" do
    scenario 'adding a new restaurant' do
      visit '/restaurants/new'
      expect(page).to have_content('Name')
      fill_in('restaurant_name', :with => "Dirty Bones")
      fill_in('restaurant_description', :with => "Dirty")
      fill_in('restaurant_address', :with => "Kensington Church Street")
      click_button('Create Restaurant')
      expect(current_path).to eq '/restaurants'
    end
  end

  context "viewing restaurants" do

    let!(:kfc){ Restaurant.create(name: "KFC", rating: 4, address: "London", description: "chicken") }

    scenario "user can view a restaurant page" do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
end
