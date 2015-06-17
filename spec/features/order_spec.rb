require 'rails_helper'

describe 'creating a new order', type: :feature do

  it "adds an item to cart" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Item #1')
    expect(page).to have_text('Description of Item')
    expect(page).to have_text('$18.00')
  end


end
