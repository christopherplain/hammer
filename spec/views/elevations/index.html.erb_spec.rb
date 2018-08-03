require 'rails_helper'

RSpec.describe "elevations/index", type: :view do
  before(:each) do
    assign(:elevations, [
      Elevation.create!(
        :orientation => "Orientation",
        :u_location => 2,
        :part_number => "Part Number",
        :sku => "Sku"
      ),
      Elevation.create!(
        :orientation => "Orientation",
        :u_location => 2,
        :part_number => "Part Number",
        :sku => "Sku"
      )
    ])
  end

  it "renders a list of elevations" do
    render
    assert_select "tr>td", :text => "Orientation".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Part Number".to_s, :count => 2
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
  end
end
