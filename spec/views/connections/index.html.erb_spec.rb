require 'rails_helper'

RSpec.describe "connections/index", type: :view do
  before(:each) do
    assign(:connections, [
      Connection.create!(
        :connection_type => "Connection Type",
        :local_port => "Local Port",
        :remote_port => "Remote Port",
        :cable_type => "Cable Type",
        :cable_color => "Cable Color",
        :cable_length => "Cable Length"
      ),
      Connection.create!(
        :connection_type => "Connection Type",
        :local_port => "Local Port",
        :remote_port => "Remote Port",
        :cable_type => "Cable Type",
        :cable_color => "Cable Color",
        :cable_length => "Cable Length"
      )
    ])
  end

  it "renders a list of connections" do
    render
    assert_select "tr>td", :text => "Connection Type".to_s, :count => 2
    assert_select "tr>td", :text => "Local Port".to_s, :count => 2
    assert_select "tr>td", :text => "Remote Port".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Type".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Color".to_s, :count => 2
    assert_select "tr>td", :text => "Cable Length".to_s, :count => 2
  end
end
