require 'rails_helper'

RSpec.describe "readings/show", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @vital = FactoryBot.create(:vital, user: @user)
    @reading = assign(:reading, Reading.create!(
      numeric_reading: "9.99",
      vital: @vital,
      user: @user,
      measured_at: Time.current
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(@vital.name)
    expect(rendered).to match(@reading.measured_at.to_s)
  end
end
