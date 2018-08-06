require 'rails_helper'

RSpec.describe "parts/edit", type: :view do
  before(:each) do
    @part = assign(:part, Part.create!(
      :part_number => "MyString",
      :manufacturer => "MyString",
      :model => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit part form" do
    render

    assert_select "form[action=?][method=?]", part_path(@part), "post" do

      assert_select "input[name=?]", "part[part_number]"

      assert_select "input[name=?]", "part[manufacturer]"

      assert_select "input[name=?]", "part[model]"

      assert_select "input[name=?]", "part[description]"
    end
  end
end
