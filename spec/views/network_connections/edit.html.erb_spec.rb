require 'rails_helper'

RSpec.describe "network_connections/edit", type: :view do
  before(:each) do
    @network_connection = assign(:network_connection, NetworkConnection.create!(
      :device1_port => "MyString",
      :device2_port => "MyString",
      :cable_type => "MyString",
      :cable_color => "MyString",
      :cable_length => "MyString"
    ))
  end

  it "renders the edit network_connection form" do
    render

    assert_select "form[action=?][method=?]", network_connection_path(@network_connection), "post" do

      assert_select "input[name=?]", "network_connection[device1_port]"

      assert_select "input[name=?]", "network_connection[device2_port]"

      assert_select "input[name=?]", "network_connection[cable_type]"

      assert_select "input[name=?]", "network_connection[cable_color]"

      assert_select "input[name=?]", "network_connection[cable_length]"
    end
  end
end
