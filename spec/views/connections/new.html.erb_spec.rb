require 'rails_helper'

RSpec.describe "connections/new", type: :view do
  before(:each) do
    assign(:connection, Connection.new(
      :connection_type => "MyString",
      :local_port => "MyString",
      :remote_port => "MyString",
      :cable_type => "MyString",
      :cable_color => "MyString",
      :cable_length => "MyString"
    ))
  end

  it "renders new connection form" do
    render

    assert_select "form[action=?][method=?]", connections_path, "post" do

      assert_select "input[name=?]", "connection[connection_type]"

      assert_select "input[name=?]", "connection[local_port]"

      assert_select "input[name=?]", "connection[remote_port]"

      assert_select "input[name=?]", "connection[cable_type]"

      assert_select "input[name=?]", "connection[cable_color]"

      assert_select "input[name=?]", "connection[cable_length]"
    end
  end
end
