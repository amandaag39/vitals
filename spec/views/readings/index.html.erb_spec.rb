require 'rails_helper'

RSpec.describe "readings/index", type: :view do
  before(:each) do
    assign(:readings, [
      Reading.create!(
        numeric_reading: "9.99",
        vital: nil,
        user: nil
      ),
      Reading.create!(
        numeric_reading: "9.99",
        vital: nil,
        user: nil
      )
    ])
  end

  it "renders a list of readings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
