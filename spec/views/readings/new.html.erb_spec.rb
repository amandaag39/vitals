require 'rails_helper'

RSpec.describe "readings/new", type: :view do
  before(:each) do
    user = FactoryBot.create(:user)
    vitals = FactoryBot.create_list(:vital, 3, user: user) # Creates 3 vitals for the user
    assign(:reading, Reading.new)
    assign(:user_vitals, vitals) # Ensures @user_vitals is not nil and has items
  end

  it "renders new reading form" do
    render

    assert_select "form[action=?][method=?]", readings_path, "post" do
      assert_select "input[name=?]", "reading[numeric_reading]"
      assert_select "input[name=?]", "reading[measured_at]"
      assert_select "select[name=?]", "reading[vital_id]"
    end
  end
end
