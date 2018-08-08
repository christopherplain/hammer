require 'rails_helper'

RSpec.describe "network_connections/show", type: :view do
  before(:each) do
    @network_connection = assign(:network_connection, NetworkConnection.create!(
      :device1_port => "Device1 Port",
      :device2_port => "Device2 Port",
      :cable_type => "Cable Type",
      :cable_color => "Cable Color",
      :cable_length => "Cable Length"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Device1 Port/)
    expect(rendered).to match(/Device2 Port/)
    expect(rendered).to match(/Cable Type/)
    expect(rendered).to match(/Cable Color/)
    expect(rendered).to match(/Cable Length/)
  end
end
