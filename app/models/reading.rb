# == Schema Information
#
# Table name: readings
#
#  id              :integer          not null, primary key
#  measured_at     :datetime
#  numeric_reading :decimal(5, 2)
#  vital_id        :integer          not null
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Reading < ApplicationRecord
  validates :vital_id, :user_id, presence: { message: "You need to select a vital type." }
  validates :measured_at, presence: true
  validates :numeric_reading, numericality: true, allow_nil: true
  validate :appropriate_reading_type_present

  belongs_to :vital
  belongs_to :user
  has_one_attached :image

  scope :measured_at_between, ->(start_date, end_date) { where(measured_at: start_date..end_date) }
  scope :measured_at_before, ->(end_date) { where("measured_at < ?", end_date) }
  scope :measured_at_after, ->(start_date) { where("measured_at > ?", start_date) }
  scope :for_vital_and_category, ->(name, category) {
    joins(:vital).where(vitals: { name: name, category: Vital.categories[category] })
  }
  scope :for_numerical_prompt, -> { select(:measured_at, :numeric_reading) }
  scope :for_text_prompt, -> { select(:measured_at, :text_reading) }
  scope :default_order, -> { order('readings.measured_at DESC') }

  private

  def appropriate_reading_type_present
    case vital.category
    when 'numerical'
      errors.add(:numeric_reading, "must be provided for a numerical vital") if numeric_reading.blank?
    when 'text'
      errors.add(:text_reading, "must be provided for a text vital") if text_reading.blank?
    when 'image'
      errors.add(:image, "must be attached for an image vital") unless image.attached?
    end
  end
end
