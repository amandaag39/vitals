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
  let(:user) { FactoryBot.create(:user) } 
  
  subject {
    described_class.new(
      name: "Heart Rate",
      category: :numerical,
      user: user
    )
  }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end
    

    it 'is not valid without a category' do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:category]).to include("can't be blank")
    end
    

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate name for the same user' do
      existing_vital = FactoryBot.create(:vital, name: "Heart Rate", category: :numerical, user: subject.user)
      duplicate_vital = subject.class.new(name: existing_vital.name, category: :numerical, user: existing_vital.user)
      expect(duplicate_vital).to_not be_valid
      expect(duplicate_vital.errors[:name]).to include("has already been taken") # Checking the error message
    end    

    it 'only allows valid categories' do
      expect {
        subject.category = :invalid_category
      }.to raise_error(ArgumentError)
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(subject.user).to eq(user)
    end
  end
end
