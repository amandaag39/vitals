require 'rails_helper'

RSpec.describe "readings/edit", type: :view do
  let(:reading) {
    Reading.create!(
      numeric_reading: "9.99",
      vital: nil,
      user: nil
    )
  }

  before(:each) do
    assign(:reading, reading)
  end

  it "renders the edit reading form" do
    render

    assert_select "form[action=?][method=?]", reading_path(reading), "post" do

      assert_select "input[name=?]", "reading[numeric_reading]"

      assert_select "input[name=?]", "reading[vital_id]"

      assert_select "input[name=?]", "reading[user_id]"
    end
  end
end
