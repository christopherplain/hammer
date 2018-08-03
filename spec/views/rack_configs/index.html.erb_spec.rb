require 'rails_helper'

RSpec.describe "rack_configs/index", type: :view do
  before(:each) do
    assign(:rack_configs, [
      RackConfig.create!(
        :customer => "Customer",
        :sku => "Sku"
      ),
      RackConfig.create!(
        :customer => "Customer",
        :sku => "Sku"
      )
    ])
  end

  it "renders a list of rack_configs" do
    render
    assert_select "tr>td", :text => "Customer".to_s, :count => 2
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
  end
end
