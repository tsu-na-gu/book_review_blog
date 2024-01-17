FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Name_#{n}" }
  end
end
