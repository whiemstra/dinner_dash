require 'rails_helper'

describe 'Creating a New Item', type: :feature do

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
  end

  it 'blocks a regular user from creating an item' do
    expect(current_path).to eq(items_path)
    expect(page).to_not have_content('Add New Item')
  end


end

describe 'view an item', type: :feature do

  before(:each) do
    Item.create(title: "Item #1", description: "item description", price: 10)
  end

  it 'lists all items on items page' do
    visit items_path
    expect(page).to have_text("All Items")
    expect(page).to have_text("Item #1")
  end

  it "visits the items page when that item title is clicked" do
    visit items_path
    click_on('Item #1')

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text('Item #1')
    expect(page).to have_text(10)
  end
end


describe 'editing an existing item', type: :feature do
  before(:each) do
    @item = Item.create(title: "Item #1",
      description: "sweet item description", price: 10)
  end

  it 'blocks a regular user from editing an item'

  it 'allows updating items from only admin user(s)'

  it 'allows changing the title, description, and/or price' do

    visit edit_item_path(@item)
    expect(page).to have_text('Edit Item')

    fill_in('Title', with: 'Item #4')
    fill_in('Description', with: 'Better description')
    fill_in('Price', with: 17)
    click_on('Update')

    # visit category_path(curr_category)
    expect(page).to have_no_text('Item #1')
    expect(page).to have_text('Item #4')
    expect(page).to have_no_text('sweet item description')
    expect(page).to have_text('Better description')
    expect(page).to have_no_text(10)
    expect(page).to have_text(17)
  end

  it 'allows changing the category of the item'

  xit 'has an edit link next to the item on the items own page' do
    my_category = FactoryGirl.create(:category, title: 'My Category')
    existing_item = FactoryGirl.create(:item, title: 'Existing Item',
                                       description: 'Existing Item Description',
                                       category: my_category)

    visit items_path(existing_item)
    expect(page).to have_link('Edit', href: edit_item_path(existing_item))
  end

  it 'blocks a unauthenticated admin user from editing an item'

  it 'allows an authenticated admin user to edit an item'

end


describe 'deleting an existing item', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Food", description: "fatty food", price: 10)
    @item2 = Item.create(title: "Drink", description: "wine", price: 10)
    @item3 = Item.create(title: "Alcohol", description: "beer", price: 10)
  end

  it 'allows an item to be deleted' do

    visit item_path(@item2)
    click_on "Delete Item"

    expect(current_path).to eq(items_path)
    expect(page).not_to have_text("Drink")
  end

  it 'blocks a regular user from deleting an item'

  it 'blocks a unauthenticated admin user from deleting an item'

  it 'allows an authenticated admin user to delete an item'

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

