require 'rails_helper'

RSpec.describe "parts/show", type: :view do
  before(:each) do
    @part = assign(:part, Part.create!(
      :part_number => "Part Number",
      :manufacturer => "Manufacturer",
      :model => "Model",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Part Number/)
    expect(rendered).to match(/Manufacturer/)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/Description/)
  end
end
