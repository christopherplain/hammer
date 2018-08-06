require 'rails_helper'

RSpec.describe "parts/index", type: :view do
  before(:each) do
    assign(:parts, [
      Part.create!(
        :part_number => "Part Number",
        :manufacturer => "Manufacturer",
        :model => "Model",
        :description => "Description"
      ),
      Part.create!(
        :part_number => "Part Number",
        :manufacturer => "Manufacturer",
        :model => "Model",
        :description => "Description"
      )
    ])
  end

  it "renders a list of parts" do
    render
    assert_select "tr>td", :text => "Part Number".to_s, :count => 2
    assert_select "tr>td", :text => "Manufacturer".to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
