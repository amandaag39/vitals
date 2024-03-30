require 'rails_helper'

RSpec.describe Reading, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:vital) { FactoryBot.create(:vital, user: user) } # Ensure your factories are set up for Vital and User

  subject {
    described_class.new(
      measured_at: DateTime.now,
      numeric_reading: 98.6,
      vital: vital,
      user: user
    )
  }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a measured_at' do
      subject.measured_at = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a vital' do
      subject.vital = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(subject.user).to eq(user)
    end

    it 'belongs to a vital' do
      expect(subject.vital).to eq(vital)
    end
  end
end
