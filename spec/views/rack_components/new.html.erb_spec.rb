require 'rails_helper'

RSpec.describe "rack_components/new", type: :view do
  before(:each) do
    assign(:rack_component, RackComponent.new(
      :u_location => 1,
      :orientation => "MyString",
      :part_number => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders new rack_component form" do
    render

    assert_select "form[action=?][method=?]", rack_components_path, "post" do

      assert_select "input[name=?]", "rack_component[u_location]"

      assert_select "input[name=?]", "rack_component[orientation]"

      assert_select "input[name=?]", "rack_component[part_number]"

      assert_select "input[name=?]", "rack_component[sku]"
    end
  end
end
