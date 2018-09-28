require 'rails_helper'

RSpec.describe "components/show", type: :view do
  before(:each) do
    @component = assign(:component, Component.create!(
      :u_location => 2,
      :orientation => "Orientation",
      :part_number => "Part Number",
      :sku => "Sku"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Orientation/)
    expect(rendered).to match(/Part Number/)
    expect(rendered).to match(/Sku/)
  end
end
