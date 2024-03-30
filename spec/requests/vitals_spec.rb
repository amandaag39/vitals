# spec/requests/vitals_spec.rb
require 'rails_helper'

RSpec.describe "Vitals", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  it 'allows a user to create a vital and then view it' do
    post vitals_path, params: { vital: { name: "Heart Rate", category: "numerical" } }
    vital = Vital.last
    expect(vital.name).to eq("Heart Rate")
    
    get vital_path(vital)
    expect(response).to have_http_status(200)
    expect(response.body).to include("Heart Rate")
  end
end
