require 'rails_helper'

RSpec.describe "rack_components/index", type: :view do
  before(:each) do
    assign(:rack_components, [
      RackComponent.create!(
        :u_location => 2,
        :orientation => "Orientation",
        :part_number => "Part Number",
        :sku => "Sku"
      ),
      RackComponent.create!(
        :u_location => 2,
        :orientation => "Orientation",
        :part_number => "Part Number",
        :sku => "Sku"
      )
    ])
  end

  it "renders a list of rack_components" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Orientation".to_s, :count => 2
    assert_select "tr>td", :text => "Part Number".to_s, :count => 2
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
  end
end
