class Vital < ApplicationRecord
  enum category: { numerical: 0, text: 1, image: 2 }
  belongs_to :user
  has_many :readings

  def self.category_options
    categories.keys.map { |key| [key.humanize, key] }
  end
end
