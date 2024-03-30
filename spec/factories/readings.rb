# spec/factories/readings.rb
FactoryBot.define do
    factory :reading do
      numeric_reading { 70 }
      measured_at { Time.current }
      vital
    end
  end