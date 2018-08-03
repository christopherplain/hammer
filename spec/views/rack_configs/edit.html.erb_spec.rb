require 'rails_helper'

RSpec.describe "rack_configs/edit", type: :view do
  before(:each) do
    @rack_config = assign(:rack_config, RackConfig.create!(
      :customer => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders the edit rack_config form" do
    render

    assert_select "form[action=?][method=?]", rack_config_path(@rack_config), "post" do

      assert_select "input[name=?]", "rack_config[customer]"

      assert_select "input[name=?]", "rack_config[sku]"
    end
  end
end
