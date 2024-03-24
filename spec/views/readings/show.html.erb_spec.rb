require 'rails_helper'

RSpec.describe "readings/show", type: :view do
  before(:each) do
    assign(:reading, Reading.create!(
      numeric_reading: "9.99",
      vital: nil,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
