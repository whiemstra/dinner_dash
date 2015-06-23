require 'rails_helper'

RSpec.describe User, type: :model do
  let(:new_user) { User.new }

  it {should validate_presence_of(:full_name)}
  it {should validate_length_of(:display_name).is_at_least(2).is_at_most(32) }
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}

  it 'has a set of orders associated to it' do
    expect(new_user).to respond_to(:orders)
    expect(new_user).to respond_to(:orders=)
  end

  it 'has a full_name attribute' do
    expect(new_user).to respond_to(:full_name)
    expect(new_user).to respond_to(:full_name=)
  end

  it 'can have a display_name, but must be unique' do
    expect(new_user).to respond_to(:display_name)
    expect(new_user).to respond_to(:display_name=)
  end

  it 'has a email attribute' do
    expect(new_user).to respond_to(:email)
    expect(new_user).to respond_to(:email=)
  end

  it 'has a password attribute' do
    expect(new_user).to respond_to(:password)
    expect(new_user).to respond_to(:password=)
  end


  it 'requires a full_name, email, & password to be valid' do
    expect(new_user).to_not be_valid
    new_user.full_name = "kevin"
    new_user.email = "kevin@email.com"

    expect(new_user).to_not be_valid

    new_user.password = "pa$$word"

    expect(new_user).to be_valid
  end
end
