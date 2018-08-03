require 'rails_helper'

RSpec.describe "elevations/edit", type: :view do
  before(:each) do
    @elevation = assign(:elevation, Elevation.create!(
      :orientation => "MyString",
      :u_location => 1,
      :part_number => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders the edit elevation form" do
    render

    assert_select "form[action=?][method=?]", elevation_path(@elevation), "post" do

      assert_select "input[name=?]", "elevation[orientation]"

      assert_select "input[name=?]", "elevation[u_location]"

      assert_select "input[name=?]", "elevation[part_number]"

      assert_select "input[name=?]", "elevation[sku]"
    end
  end
end
