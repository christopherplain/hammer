require 'rails_helper'

RSpec.describe "components/new", type: :view do
  before(:each) do
    assign(:component, Component.new(
      :u_location => 1,
      :orientation => "MyString",
      :part_number => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders new component form" do
    render

    assert_select "form[action=?][method=?]", components_path, "post" do

      assert_select "input[name=?]", "component[u_location]"

      assert_select "input[name=?]", "component[orientation]"

      assert_select "input[name=?]", "component[part_number]"

      assert_select "input[name=?]", "component[sku]"
    end
  end
end
