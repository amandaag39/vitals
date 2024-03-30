# spec/requests/homepage_spec.rb
require 'rails_helper'

RSpec.describe "Homepage", type: :request do
  it 'loads successfully' do
    get root_path
    expect(response).to have_http_status(200)
  end
end