require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Item #1", description: "food", price: 10)
    @item2 = Item.create(title: "Item #2", description: "wine", price: 12)
    @item3 = Item.create(title: "Item #3", description: "beer", price: 5)
  end

  it 'can browse all items on home page' do
    visit items_path
    expect(current_path).to eq(items_path)
    expect(page).to have_content("Item #1")
    expect(page).to have_content("Item #2")
    expect(page).to have_content(5)
  end

  it 'can browse items by a category' do
    category = Category.create(title: "Category Name")
    category.items.create(title: "Item Title #38", description: "slammin' description here", price: 5 )
    visit root_path
    click_on "Category Name"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content("slammin' description here")
    expect(page).to have_content("Item Title #38")
  end

  it 'can add an item to my cart'

  it 'can view'

  it 'can remove an item from cart'

  it 'can ncrease the quantity of a item in my cart'

  it 'log in and cart does not get cleared'
end


describe 'user signup', type: :feature do

  it 'has a link on the home page that links to a sign up form' do
    visit items_path
    expect(page).to have_link('Signup', new_user_path)

    click_link "Signup"
    expect(page).to have_text('Create Your Account')

  end

  it 'can create an account' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name",    with: "Whitney"
      fill_in "Display Name", with: "whithub"
      fill_in "Email",        with: "WhitTheShit@gmail.com"
      fill_in "Password",     with: "dinnerdash"
      click_button "Create Account"
    end

    expect(page).to have_content("All Items")
    expect(current_path).to eql(items_path)
  end

  it 'can sign up without a display name' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name", with: "Drewby Mine"
      fill_in "Email",     with: "drewbyonrails@gmail.com"
      fill_in "Password",  with: "pa$$word"
      click_button "Create Account"
    end

    expect(page).to have_content("All Items")
    expect(current_path).to eql(items_path)
  end


  it 'errors if full_name, email, OR password are blank' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name", with: "Vane"
      fill_in "Password",  with: "vane.uniq"
      click_button "Create Account"
    end

    expect(page).to have_text('Create Your Account')
    expect(page).to have_text("Email can't be blank")
  end

  it 'asks for an optional display name, does not error if left blank'

end

describe 'user log in', type: :feature do

  it 'has a link on the home page that links to a sign up form'

    # xit "can log   in an existing user" do
  #   user = User.create(username: "whit", password: "hello123")
  #
  #   visit login_path
  #
  #   fill_in "Username", with: user.username
  #   fill_in "Password", with: "hello123"
  #   click_button "Login"
  #
  #   expect(page).to have_content("Welcome, whitney")
  #
  # end


  xit 'sends people to the login page if not logged in'
  xit 'redirects to the categories page after logging in'
  xit 'errors if username does not exist'
  xit 'errors if username exists but password is wrong'
  xit 'errors if username and password are blank'
end

describe 'user log out', type: :feature do


  # test "logged in user can log out" do
  #   user = User.create(username: "rachel", password: "password")
  #
  #   visit login_path
  #   fill_in "Username", with: user.username
  #   fill_in "Password", with: "password"
  #   click_button "Login"
  #
  #   assert page.has_content?("Welcome, rachel")
  #
  #   click_link "Logout"
  #
  #   refute page.has_content?("Welcome, rachel")
  # end


  xit 'only shows a link if logged in'
  xit 'logs a user out when clicked'
  xit 'does not allow people to access pages when logged out'
end

