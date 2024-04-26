# == Schema Information
#
# Table name: vitals
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :integer
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vital < ApplicationRecord
  enum category: { numerical: 0, text: 1, image: 2 }
  belongs_to :user
  has_many :readings, dependent: :restrict_with_error
  validates :user, presence: true
  validates :name, uniqueness: { scope: :user_id }, presence: true
  validates :category, presence: true

  scope :numerical, -> { where(category: categories[:numerical]) }
  scope :text, -> { where(category: categories[:text]) }

  def self.category_options
    categories.keys.map { |key| [key.humanize, key] }
  end

  def to_s
    "#{name}"
  end

  def chart_data(start_date, end_date)
    return {} unless numerical?  # Ensure this method only works for numerical vitals

    readings.measured_at_between(start_date, end_date)
            .group_by_day(:measured_at)
            .average(:numeric_reading)
  end
end
