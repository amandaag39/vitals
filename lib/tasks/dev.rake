desc "Fill the database tables with some sample data"
task sample_data: :environment do
  
  if Rails.env.development?
    Reading.destroy_all
    Vital.destroy_all
    User.destroy_all
    puts "Cleared the database."
  end

  2.times do |i|
    name = Faker::Name.first_name.downcase
    email = "#{name}@example.com"
    
    user = User.create!(
      email: email,
      password: 'password',
      password_confirmation: 'password'
    )
  
    if user.persisted?
      vital_names = ["Blood Oxygen", "Heart Rate", "Blood Glucose"]
      vitals = vital_names.each do |vital_name|
        user.vitals.create!(name: vital_name, category: :numerical)
      end

      start_date = 1.year.ago.to_date
      end_date = Date.yesterday

      (start_date..end_date).each do |date|
        user.vitals.each do |vital|
          Reading.create!(
            measured_at: Faker::Time.between(from: date.beginning_of_day, to: date.end_of_day),
            numeric_reading: Faker::Number.between(from: 1, to: 100),
            vital: vital,
            user: user
          )
        end
      end
    else
      puts "Failed to create user: #{user.errors.full_messages.to_sentence}"
    end
  end
  
  puts "Added #{User.count} Users, #{Vital.count} Vitals, and #{Reading.count} Readings."
end
