require 'rails_helper'

RSpec.describe "rack_configs/new", type: :view do
  before(:each) do
    assign(:rack_config, RackConfig.new(
      :customer => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders new rack_config form" do
    render

    assert_select "form[action=?][method=?]", rack_configs_path, "post" do

      assert_select "input[name=?]", "rack_config[customer]"

      assert_select "input[name=?]", "rack_config[sku]"
    end
  end
end
