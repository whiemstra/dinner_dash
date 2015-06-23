FactoryGirl.define do
  factory :category do
    sequence :title do |n|
      "Category Factory ##{n}"
    end
  end

end
