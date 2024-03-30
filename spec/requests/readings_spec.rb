require 'rails_helper'

RSpec.describe "/readings", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:vital) { FactoryBot.create(:vital, user: user) } # This creates a vital associated with the user.

  before do
    sign_in user
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) { { numeric_reading: 70, measured_at: Time.current, vital_id: vital.id } }

      it "creates a new Reading and redirects to the show page of the created reading" do
        post readings_url, params: { reading: valid_attributes }
        reading = Reading.last
        expect(response).to redirect_to(reading_url(reading))
      end
    end
  end
end
