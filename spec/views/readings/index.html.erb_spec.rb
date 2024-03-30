require 'rails_helper'

RSpec.describe "readings/index", type: :view do
  before(:each) do
    user = FactoryBot.create(:user)
    vital = FactoryBot.create(:vital, user: user, name: "Heart Rate")
    assign(:readings, [
      Reading.create!(
        numeric_reading: "9.99",
        vital: vital,
        user: user,
        measured_at: Time.current
      ),
      Reading.create!(
        numeric_reading: "8.88",
        vital: vital,
        user: user,
        measured_at: Time.current
      )
    ])
  end

  it "renders a list of readings" do
    render
    expect(rendered).to include("9.99")
    expect(rendered).to include("8.88")
    expect(rendered).to match(/Show this reading/)
  end
  
end
