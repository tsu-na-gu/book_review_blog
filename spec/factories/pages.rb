FactoryBot.define do
  factory :page do
    user { create(:user) }
    sequence(:title) { |n| "Page Title #{n}" }
    sequence(:slug) { |n| "page-title-#{n}" }
    author { 'Greg Donald#' }
    publisher { 'apress' }
    publisher_url { 'https://www.apress.com/gp' }
    sequence(:summary) { |n| "<p>Page smmary goes here #{n}" }
    sequence(:content) { |n| "<p>Page content goes here #{n}" }
    created_at { Time.zone.now }
    published { false }
  end

  trait :published do
    published { true }
  end
end
