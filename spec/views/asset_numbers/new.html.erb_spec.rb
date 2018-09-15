require 'rails_helper'

RSpec.describe "asset_numbers/new", type: :view do
  before(:each) do
    assign(:asset_number, AssetNumber.new(
      :num => "MyString"
    ))
  end

  it "renders new asset_number form" do
    render

    assert_select "form[action=?][method=?]", asset_numbers_path, "post" do

      assert_select "input[name=?]", "asset_number[num]"
    end
  end
end
