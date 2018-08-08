require 'rails_helper'

RSpec.describe "network_connections/index", type: :view do
  before(:each) do
    assign(:network_connections, [
      NetworkConnection.create!(
        :device1_port => "Device1 Port",
        :device2_port => "Device2 Port",
        :cable_type => "Cable Type",
        :cable_color => "Cable Color",
        :cable_length => "Cable Length"
      ),
      NetworkConnection.create!(
        :device1_port => "Device1 Port",
        :device2_port => "Device2 Port",
        :cable_type => "Cable Type",
        :cable_color => "Cable Color",
        :cable_length => "Cable Length"
      )
    ])
  end

  it "renders a list of network_connections" do
    render
    assert_select "tr>td", :text => "Device1 Port".to_s, :count => 2
    assert_select "tr>td", :text => "Device2 Port".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Type".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Color".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Length".to_s, :count => 2
  end
end
