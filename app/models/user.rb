# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vitals, dependent: :destroy
  has_many :readings, through: :vitals

  # TODO: consider combining numeric_reading and text_reading into 1 'value' column
  def fetch_numerical_data(numerical_vital_name, start_date, end_date)
    readings
      .measured_at_after(start_date)
      .measured_at_before(end_date)
      .for_vital_and_category(numerical_vital_name, "numerical")
      .for_numerical_prompt
      .default_order
  end

  def fetch_text_data(text_vital_name, start_date, end_date)
    readings
      .measured_at_after(start_date)
      .measured_at_before(end_date)
      .for_vital_and_category(text_vital_name, "text")
      .for_text_prompt
      .default_order
  end

  # TODO: consider passing in array of vital names eg ["meals", "blood glucose", "symptoms"]
  def prompt(numerical_vital_name, text_vital_name, start_date, end_date)
    numerical_data = fetch_numerical_data(numerical_vital_name, start_date, end_date)
    text_data = fetch_text_data(text_vital_name, start_date, end_date)

    numerical_readings_formatted = numerical_data.map { |entry| "#{entry.measured_at.strftime("%Y-%m-%d %H:%M")}: #{entry.numeric_reading}" }.join("\n")
    text_readings_formatted = text_data.map { |entry| "#{entry.measured_at.strftime("%Y-%m-%d %H:%M")}: #{entry.text_reading}" }.join("\n")

    <<~PROMPT
      You are a holistic nutritionist seeking to analyze a patient's daily health logs including one or more biomarkers and their meals.
      Your approach to treating people is that each individual reacts differently to different foods.
      With that in mind, please look for correlations between certain meals and fluctuations in biomarker readings and provide those insights.
      Please format the correlations in markdown in a list with a space in between each insight.
      Please also give the patient one actionable step they can take that's simple to improve their situation. Format the analysis in markdown as well.
      The analysis can be detailed, but please give it a bold heading and make the actionable step as simple to understand a possible.
      Finally the response should be addressed directly to the patient, but you response should be approachable and mimic an in person conversation.
      Analyze the following user data. 
      Numerical readings of #{numerical_vital_name} and textual descriptions of #{text_vital_name}:

      #{numerical_vital_name} readings:
      #{numerical_readings_formatted}

      #{text_vital_name} descriptions:
      #{text_readings_formatted}
    PROMPT
  end
end
