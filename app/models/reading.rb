class Reading < ApplicationRecord
  validates :vital_id, presence: { message: "You need to select a vital type." }
  belongs_to :vital
  belongs_to :user
  has_one_attached :image
end
