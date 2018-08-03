require 'rails_helper'

RSpec.describe "rack_configs/show", type: :view do
  before(:each) do
    @rack_config = assign(:rack_config, RackConfig.create!(
      :customer => "Customer",
      :sku => "Sku"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Customer/)
    expect(rendered).to match(/Sku/)
  end
end
