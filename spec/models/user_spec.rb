require 'rails_helper'

RSpec.describe User, type: :model do
  let(:new_user) { User.new }

  it 'has a set of orders associated to it' do
    expect(new_user).to respond_to(:orders)
    expect(new_user).to respond_to(:orders=)
  end

  it 'should have more tests yeah'
end
