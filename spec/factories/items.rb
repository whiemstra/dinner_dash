FactoryGirl.define do
  factory :item do
    sequence :title do |n|
      "My #{n} favorite item"
    end
    description 'abc'
    price 45
  end

end
