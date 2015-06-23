require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  before(:each) do
    category1 = FactoryGirl.create(:category, title: "Category #1")
    category2 = FactoryGirl.create(:category, title: "Category #2")
    Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
    Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])
    visit items_path
  end

  it 'can view, add, and remove items from cart' do
    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click
    expect(page).to have_content("You now have 3 Item Title #1s in your cart.")

    click_on("Toggle navigation")
    find('#cart').click
    expect(page).to have_content("Item Title #1")
    expect(page).to have_content('$75.00')

    click_on "Remove"
    expect(page).to have_content("You have removed Item Title #1 from your cart.")
    expect(page).to_not have_content('$75.00')
  end

  it 'can increase the quantity of a item in my cart' do
    first(:button, "Add to Cart").click
    expect(page).to have_content("You now have 1 Item Title #1 in your cart.")

    click_on("Toggle navigation")
    find('#cart').click

    expect(page).to have_content('$25.00')

    click_button "+"
    click_button "+"

    expect(page).to have_content('$75.00')
  end

  it 'log in and cart does not get cleared' do
    @user = User.create(full_name: "Tom Petty",
                        display_name: 'Tom',
                        email: "petty@gmail.com",
                        password: "freefallin")

    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click
    expect(page).to have_content("You now have 2 Item Title #1s in your cart.")



    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email",    with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    click_on("Toggle navigation")
    find('#cart').click

    expect(page).to have_content('$50.00')
    expect(page).to have_content("Item Title #1")
  end
end
