desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    Reading.destroy_all
    Vital.destroy_all
    User.destroy_all
    puts "Cleared the database."
  end

  # Create a single user named Alice
  user = User.create!(
    email: "alice@example.com",
    password: "password",
    password_confirmation: "password",
  )

  if user.persisted?
    # Create vitals for Blood Glucose and Meals
    blood_glucose_vital = user.vitals.create!(name: "Blood Glucose", category: :numerical)
    meals_vital = user.vitals.create!(name: "Meals", category: :text)

    start_date = 6.months.ago.to_date
    end_date = Date.yesterday

    meal_times = ["8:00", "12:00", "18:00"]

    (start_date..end_date).each do |date|
      # Generate text readings for Meals and Blood Glucose 30 minutes after
      meal_times.each do |meal_time|
        meal_datetime = Time.zone.parse("#{date} #{meal_time}")

        # Create meal reading
        Reading.create!(
          measured_at: meal_datetime,
          text_reading: Faker::Food.description,
          vital: meals_vital,
          user: user,
        )

        # Create blood glucose reading 30 minutes after meal
        Reading.create!(
          measured_at: meal_datetime + 30.minutes,
          numeric_reading: Faker::Number.between(from: 70, to: 180),
          vital: blood_glucose_vital,
          user: user,
        )
      end
    end
  else
    puts "Failed to create user: #{user.errors.full_messages.to_sentence}"
  end

  puts "Added #{User.count} User, #{Vital.count} Vitals, and #{Reading.count} Readings."
end
