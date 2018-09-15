require 'rails_helper'

RSpec.describe "asset_numbers/index", type: :view do
  before(:each) do
    assign(:asset_numbers, [
      AssetNumber.create!(
        :num => "Num"
      ),
      AssetNumber.create!(
        :num => "Num"
      )
    ])
  end

  it "renders a list of asset_numbers" do
    render
    assert_select "tr>td", :text => "Num".to_s, :count => 2
  end
end
