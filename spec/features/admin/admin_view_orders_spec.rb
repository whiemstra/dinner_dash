require "rails_helper"

RSpec.describe 'Admin views orders', type: :feature do

  before(:each) do
    category1 = FactoryGirl.create(:category, title: "Category #1")
    category2 = FactoryGirl.create(:category, title: "Category #2")
    Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
    Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])

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

  it "can filter order by status" do
    expect(current_path).to eq(admin_path)

    click_on('Ordered')
    expect(page).to have_text('Ordered', count: 1)
    # expect(page).to_not have_content('Paid')
    # expect(page).to_not have_content('Completed')
    # expect(page).to_not have_content('Canceled')
    # expect(page).to_not have_content('$25.05')
    # expect(current_path).to eq('admin/orders/by-status')
  end
end
