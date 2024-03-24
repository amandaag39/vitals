require 'rails_helper'

RSpec.describe "readings/new", type: :view do
  before(:each) do
    assign(:reading, Reading.new(
      numeric_reading: "9.99",
      vital: nil,
      user: nil
    ))
  end

  it "renders new reading form" do
    render

    assert_select "form[action=?][method=?]", readings_path, "post" do

      assert_select "input[name=?]", "reading[numeric_reading]"

      assert_select "input[name=?]", "reading[vital_id]"

      assert_select "input[name=?]", "reading[user_id]"
    end
  end
end
