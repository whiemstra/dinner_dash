require 'rails_helper'

describe 'A regular user', type: :feature do

  before(:each) do

    @category = FactoryGirl.create(:category)
    Item.create!(title: "Item #1", description: "item description #1", price: 20, categories: [@category])
    @user = User.create!(full_name: "Tom Petty",
                        email: "petty@gmail.com",
                        password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email",    with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

  end

  it 'cannot create, edit, or retire an item' do
    expect(current_path).to eq(items_path)
    expect(page).to have_content ("Item #1")

    expect(page).to have_no_content('Add New Item')
    expect(page).to have_no_content('Edit Item')
    expect(page).to have_no_content('Is Available?')

    click_on "Item #1"

    expect(page).to have_no_content('Add New Item')
    expect(page).to have_no_content('Edit Item')
    expect(page).to have_no_content('Is Available?')
    expect(page).to have_content('Back to All Items')
  end

end
