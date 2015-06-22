require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Item #1", description: "food", price: 10)
    @item2 = Item.create(title: "Item #2", description: "wine", price: 12)
    @item3 = Item.create(title: "Item #3", description: "beer", price: 5)
    visit items_path
  end

  it 'cannot checkout' do
    first(:button, "Add to Cart").click
    expect(page).to have_content("You now have 1 Item #1 in your cart.")

    click_on("Toggle navigation")
    find('#cart').click

    click_on "Checkout"

    expect(page).to have_content("Log in")
    expect(current_path).to eq(login_path)
  end

end
