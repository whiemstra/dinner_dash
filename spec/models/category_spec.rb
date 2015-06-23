require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create(title: "Appetizers") }

  it "is valid" do
    expect(category).to be_valid
  end

  it "is invalid without a title" do
    category.title = nil

    expect(category).to_not be_valid
  end

  it "is invalid without a unique name" do
    category
    category2 = Category.create(title: "Appetizers")

    expect(category2).to_not be_valid
  end

  it "responds to items" do
    expect(category).to respond_to(:items)
  end
end
