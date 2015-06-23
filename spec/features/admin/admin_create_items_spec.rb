require 'rails_helper'

describe 'Admin', type: :feature do

  before(:each) do
    @admin = User.create!(full_name: "Tom Petty",
                         email: "petty@gmail.com",
                         role: 1,
                         password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email",    with: @admin.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    category1 = FactoryGirl.create(:category, title: "Category #1")
    category2 = FactoryGirl.create(:category, title: "Category #2")
    Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
    Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])
  end

  it 'has a link from the index page to add a new item' do
    expect(current_path).to eq(admin_path)
    click_on "Items"

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Add New Item')
  end


  it 'can create a new item' do
    click_on "Items"
    click_on "Add New Item"

    fill_in('Title', with: "Item Title #3")
    fill_in('Description', with: "Item Description")
    fill_in('Price', with: 300 )
    check("Category #1")
    click_on "Create Item"

    expect(page).to have_text("Item was successfully created")
  end

  it 'errors if title, description, price, or category are blank' do
    click_on "Items"
    click_on "Add New Item"
    expect(page).to have_text('Creating a New Item')

    fill_in('Title', with: "Item title")
    fill_in('Description', with: 'my new item')
    click_on('Create Item')

    expect(page).to have_text('Creating a New Item')
    expect(page).to have_text("Price can't be blank")
    expect(page).to have_text("Categories must have at least one assigned category")

  end

  it 'must have a unique title for all items; errors if title is repeated' do
    visit items_path
    expect(page).to have_text('Item Title #1')

    visit new_admin_item_path
    fill_in('Title',       with: "Item Title #1")
    fill_in('Description', with: "A more slammin' description")
    fill_in('Price',       with: 3 )
    check("Category #1")
    click_on "Create Item"

    expect(page).to have_text("Title has already been taken")
  end


  it 'has a price with a decimal numeric value' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: 3500 )
    check("Category #1")

    click_on "Create Item"

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text('$35.00')
  end

  it 'must have a price greater than zero in order to be valid' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: 0 )
    check("Category #1")

    click_on "Create Item"

    expect(page).to have_text('Price must be greater than 0')

    fill_in('Price',       with: 55 )
    click_on "Create Item"
    expect(page).to have_text('Item was successfully created.')
    expect(page).to have_text('$0.55')
  end

  it 'errors when entered price has letters or symbols in it' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: '86j0')
    check("Category #1")

    click_on "Create Item"

    expect(page).to have_text('Price is not a number')

    fill_in('Price', with: '!&$%' )
    click_on "Create Item"

    expect(page).to have_text('Price is not a number')
  end

end

