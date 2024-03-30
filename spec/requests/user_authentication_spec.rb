# spec/requests/user_authentication_spec.rb
require 'rails_helper'

RSpec.describe "UserAuthentication", type: :request do
  before do
    @user = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'allows a user to sign in' do
    sign_in @user
    get root_path
    expect(response).to have_http_status(200)
  end
end
