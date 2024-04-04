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
  has_many :readings, dependent: :destroy
  validates :user, presence: true
  validates :name, uniqueness: { scope: :user_id }, presence: true
  validates :category, presence: true

  scope :numerical, -> { where(category: categories[:numerical]) }
  scope :text, -> { where(category: categories[:text]) }
  
  #for managing the enum categories
  def self.category_options
    categories.keys.map { |key| [key.humanize, key] }
  end
end
