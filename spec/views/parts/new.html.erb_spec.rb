require 'rails_helper'

RSpec.describe "parts/new", type: :view do
  before(:each) do
    assign(:part, Part.new(
      :part_number => "MyString",
      :manufacturer => "MyString",
      :model => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new part form" do
    render

    assert_select "form[action=?][method=?]", parts_path, "post" do

      assert_select "input[name=?]", "part[part_number]"

      assert_select "input[name=?]", "part[manufacturer]"

      assert_select "input[name=?]", "part[model]"

      assert_select "input[name=?]", "part[description]"
    end
  end
end
