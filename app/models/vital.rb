class Vital < ApplicationRecord
  enum category: { numerical: 0, text: 1, image: 2 }
  belongs_to :user
end
