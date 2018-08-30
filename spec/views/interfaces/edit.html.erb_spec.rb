require 'rails_helper'

RSpec.describe "interfaces/edit", type: :view do
  before(:each) do
    @interface = assign(:interface, Interface.create!(
      :interface_group => "MyString",
      :interface_type => "MyString"
    ))
  end

  it "renders the edit interface form" do
    render

    assert_select "form[action=?][method=?]", interface_path(@interface), "post" do

      assert_select "input[name=?]", "interface[interface_group]"

      assert_select "input[name=?]", "interface[interface_type]"
    end
  end
end
