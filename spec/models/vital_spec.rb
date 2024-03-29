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
require 'rails_helper'

RSpec.describe Vital, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
