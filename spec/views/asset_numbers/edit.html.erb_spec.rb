require 'rails_helper'

RSpec.describe "asset_numbers/edit", type: :view do
  before(:each) do
    @asset_number = assign(:asset_number, AssetNumber.create!(
      :num => "MyString"
    ))
  end

  it "renders the edit asset_number form" do
    render

    assert_select "form[action=?][method=?]", asset_number_path(@asset_number), "post" do

      assert_select "input[name=?]", "asset_number[num]"
    end
  end
end
