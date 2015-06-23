require "rails_helper"

RSpec.describe 'Admin views orders', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Item #1", description: "food", price: 800)
    @item2 = Item.create(title: "Item #2", description: "wine", price: 1200)
    @item3 = Item.create(title: "Item #3", description: "beer", price: 500)

    @user = User.create(full_name: "Tom Petty",
                        email: "petty@gmail.com",
                        password: "freefallin")

    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email",    with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click

    click_on("Toggle navigation")
    find('#cart').click

    click_on "Checkout"
    click_on "Confirm"
    click_on("Toggle navigation")
    click_link "Log out"
  end


  before(:each) do
    @admin = User.create(full_name: "Whitney",
                         display_name: "Whit",
                         email: "whit@email.com",
                         role: 1,
                         password: "pa$$word")

    visit root_path

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @admin.email
    fill_in "Password", with: "pa$$word"
    click_button "Login"
  end


  it "can see all orders and their statuses" do
    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Admin Dashboard")

    expect(page).to have_content("Order_id")
    expect(page).to have_content("User_id")
    expect(page).to have_content("Ordered")
    expect(page).to have_content("Paid")
    expect(page).to have_content("Cancelled")
    expect(page).to have_content("Completed")
  end

  it "can view individual orders and its info" do
    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Admin Dashboard")
    order = Order.first
    click_on(order.id)

    expect(page).to have_content("Order Information")
    expect(page).to have_content("Tom Petty")
    expect(page).to have_content("petty@gmail.com")
    expect(page).to have_content("ordered")
    expect(page).to have_content("Order Total")
  end

  it "cannot access or alter user data" do
    visit user_path(@user)

    expect(page).to_not have_content("Tom Petty Dashboard")
    expect(page).to have_content("Whit Dashboard")
  end
end
