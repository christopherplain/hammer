require 'rails_helper'

RSpec.describe "interfaces/new", type: :view do
  before(:each) do
    assign(:interface, Interface.new(
      :interface_group => "MyString",
      :interface_type => "MyString"
    ))
  end

  it "renders new interface form" do
    render

    assert_select "form[action=?][method=?]", interfaces_path, "post" do

      assert_select "input[name=?]", "interface[interface_group]"

      assert_select "input[name=?]", "interface[interface_type]"
    end
  end
end
