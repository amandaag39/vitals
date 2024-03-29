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
require 'rails_helper'

RSpec.describe Reading, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
