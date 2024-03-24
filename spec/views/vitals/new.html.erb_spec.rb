require 'rails_helper'

RSpec.describe "vitals/new", type: :view do
  before(:each) do
    assign(:vital, Vital.new(
      name: "MyString",
      category: 1,
      user: nil
    ))
  end

  it "renders new vital form" do
    render

    assert_select "form[action=?][method=?]", vitals_path, "post" do

      assert_select "input[name=?]", "vital[name]"

      assert_select "input[name=?]", "vital[category]"

      assert_select "input[name=?]", "vital[user_id]"
    end
  end
end
