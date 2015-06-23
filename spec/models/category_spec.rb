require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.new }

  it { should validate_presence_of :title }
  it { should have_many(:items) }

  it 'has a title attribute' do
    expect(category).to respond_to(:title)
    expect(category).to respond_to(:title=)
  end

  it 'is only valid if title is present' do
    expect(category).to_not be_valid
    category.title = "a valid title"
    expect(category).to be_valid
  end

  it 'blocks saving if title is absent' do
    expect(category.save).to eql(false)
    category.title = 'another valid title'
    expect(category.save).to eql(true)
  end

end
