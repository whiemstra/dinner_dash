require 'rails_helper'

describe 'Creating a New Item', type: :feature do

  before(:each) do
    @admin = User.create(full_name: "Tom Petty",
                        email: "petty@gmail.com",
                        role: 1,
                        password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @admin.email
    fill_in "Password", with: "freefallin"
    click_button "Login"
  end

  it 'has a link from the index page to add a new item' do
    expect(current_path).to eq(admin_path)
    click_on "Items"

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_link('Add New Item')
  end

  it 'lets admin create a new item' do
    click_on "Items"
    click_on "Add New Item"

    fill_in('Title', with: "Item Title")
    fill_in('Description', with: "Item Description")
    fill_in('Price', with: 3 )
    click_on "Create New Item"

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text("Item Title")
  end
end

describe "Verifying New Item Attributes", type: :feature do

  before(:each) do
    @admin = User.create(full_name: "Tom Petty",
                         email: "petty@gmail.com",
                         role: 1,
                         password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @admin.email
    fill_in "Password", with: "freefallin"
    click_button "Login"
  end

  it 'errors if title, description, or price are blank' do
    click_on "Items"
    click_on "Add New Item"
    expect(page).to have_text('Creating a New Item')

    fill_in('Description', with: 'my new item')
    click_on('Create New Item')

    expect(page).to have_text('Creating a New Item')
    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("Price can't be blank")

    fill_in('Title', with: 'Brand New Fabulous Item')
    click_on('Create New Item')

    expect(page).to have_text('Creating a New Item')
    expect(page).to have_text("Price can't be blank")
  end

  it 'must have a unique title for all items; errors if title is repeated' do
    @item = Item.create(title: "Item #1",
                        description: "Description of Item",
                        price: 18)

    visit admin_items_path
    expect(page).to have_text('Item #1')

    visit new_admin_item_path
    fill_in('Title',       with: "Item #1")
    fill_in('Description', with: "A more slammin' description")
    fill_in('Price',       with: 3 )
    click_on "Create New Item"

    expect(page).to have_text("Title has already been taken")
  end


  it 'has a price with a decimal numeric value' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: 3500 )
    click_on "Create New Item"

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text('$35.00')
  end

  it 'must have a price greater than zero in order to be valid' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: 0 )
    click_on "Create New Item"

    expect(page).to have_text('Price must be greater than 0')

    fill_in('Price',       with: 55 )
    click_on "Create New Item"
    expect(page).to have_text('Item was successfully created.')
    expect(page).to have_text('$0.55')
  end

  it 'errors when entered price has letters or symbols in it' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: '86j0')
    click_on "Create New Item"

    expect(page).to have_text('Price is not a number')

    fill_in('Price', with: '!&$%' )
    click_on "Create New Item"

    expect(page).to have_text('Price is not a number')
  end

  xit 'has a default photo if one is not given, no errors' do
    visit new_admin_item_path
    fill_in('Title',       with: "Item Title")
    fill_in('Description', with: "description of title")
    fill_in('Price',       with: 5800 )
    click_on "Create New Item"

    expect(page).to have_text('$58.00')
    epect(page).to have_content(find(".thumbnail"))
  end

end

