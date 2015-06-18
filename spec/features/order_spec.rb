require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  it "add an item to cart_items" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Item #1')
    expect(page).to have_text('Description of Item')
    expect(page).to have_text('$18.00')
  end

  xit "removes an item from cart_items" do

  end

  it "views items in cart_items" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"
    click_on("Toggle navigation")
    find('#cart').click

    expect(current_path).to eq(cart_items_path)
    expect(page).to have_text('Item #1')
    expect(page).to have_text('$18.00')
  end

end
