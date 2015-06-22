require 'rails_helper'

describe 'User/Item interaction', type: :feature do
  context 'User cannot alter an item', type: :feature do

    before(:each) do
      Item.create(title: "Item #1", description: "item description #1", price: 20)
      @user = User.create(full_name: "Tom Petty",
                          email: "petty@gmail.com",
                          password: "freefallin")
      visit root_path
      click_on("Toggle navigation")
      find('.dropdown-menu').click

      fill_in "Email", with: @user.email
      fill_in "Password", with: "freefallin"
      click_button "Login"

    end

    it 'blocks a regular user from creating, editing, or deleting an item' do
      expect(current_path).to eq(items_path)
      expect(page).to have_content ("Item #1")

      expect(page).to_not have_content('Add New Item')
      expect(page).to_not have_content('Edit Item')
      expect(page).to_not have_content('Delete Item')

      click_on "Item #1"

      expect(page).to_not have_content('Add New Item')
      expect(page).to_not have_content('Edit Item')
      expect(page).to_not have_content('Delete Item')
      expect(page).to have_content('Back to All Items')
    end
  end

  describe 'Retired items', type: :feature do

    it 'allows retired items to be viewed on items page and are marked/labeled as retired'

    it 'blocks users from adding retired items to cart'
  end
end
