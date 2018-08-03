require 'rails_helper'

RSpec.describe "elevations/new", type: :view do
  before(:each) do
    assign(:elevation, Elevation.new(
      :orientation => "MyString",
      :u_location => 1,
      :part_number => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders new elevation form" do
    render

    assert_select "form[action=?][method=?]", elevations_path, "post" do

      assert_select "input[name=?]", "elevation[orientation]"

      assert_select "input[name=?]", "elevation[u_location]"

      assert_select "input[name=?]", "elevation[part_number]"

      assert_select "input[name=?]", "elevation[sku]"
    end
  end
end