require 'rails_helper'

RSpec.describe "asset_numbers/show", type: :view do
  before(:each) do
    @asset_number = assign(:asset_number, AssetNumber.create!(
      :num => "Num"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Num/)
  end
end
