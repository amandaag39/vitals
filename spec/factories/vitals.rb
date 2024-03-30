FactoryBot.define do
  factory :vital do
    sequence(:name) { |n| "Vital #{n}" }
    category { :numerical }
    user
  end
end