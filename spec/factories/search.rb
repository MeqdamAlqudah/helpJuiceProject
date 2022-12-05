FactoryBot.define do
  factory :search do
    sequence(:search_text, 100) { |n| "search#{n}" }
    search_count { rand(1...10) }
  end
end
