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
  belongs_to :vital
  belongs_to :user
  has_one_attached :image
end
