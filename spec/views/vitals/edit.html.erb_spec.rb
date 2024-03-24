require 'rails_helper'

RSpec.describe "vitals/edit", type: :view do
  let(:vital) {
    Vital.create!(
      name: "MyString",
      category: 1,
      user: nil
    )
  }

  before(:each) do
    assign(:vital, vital)
  end

  it "renders the edit vital form" do
    render

    assert_select "form[action=?][method=?]", vital_path(vital), "post" do

      assert_select "input[name=?]", "vital[name]"

      assert_select "input[name=?]", "vital[category]"

      assert_select "input[name=?]", "vital[user_id]"
    end
  end
end
