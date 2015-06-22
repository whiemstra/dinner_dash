require 'rails_helper'

describe 'User cannot create a new item', type: :feature do

  before(:each) do
    @user = User.create(full_name: "Tom Petty",
                        email: "petty@gmail.com",
                        password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    @item1 = Item.create(title: "Item #1", description: "item description #1", price: 20)
  end

  it 'blocks a regular user from creating, editing, or deleting an item' do
    visit items_path
    expect(page).to_not have_content('Add New Item')

    click_on "Item #1"

    expect(page).to_not have_content('Edit Item')
    expect(page).to_not have_content('Delete Item')
    expect(page).to have_content('Back to All Items ')
  end

end

describe 'cart_items item(s)', type: :feature do

  it 'can add an item to the cart_items'

  it 'can remove an item from the cart_items'

  it 'can increase the quantity count of an item in the cart_items'

end


describe 'retired items', type: :feature do

  it 'allows retired items to be viewed on items page and are marked/labeled as retired'

  it 'blocks users from adding retired items to cart_items'
end

