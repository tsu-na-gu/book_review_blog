FactoryBot.define do
  factory :page do
    user { create(:user) }
    sequence(:title) { |n| "Page Title #{n}" }
    sequence(:slug) { |n| "page-title-#{n}" }
    sequence(:summary) { |n| "<p>Page smmary goes here #{n}" }
    sequence(:content) { |n| "<p>Page content goes here #{n}" }
    created_at { Time.zone.now }
    published { false }
  end
end
