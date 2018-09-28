require 'rails_helper'

RSpec.describe "components/edit", type: :view do
  before(:each) do
    @component = assign(:component, Component.create!(
      :u_location => 1,
      :orientation => "MyString",
      :part_number => "MyString",
      :sku => "MyString"
    ))
  end

  it "renders the edit component form" do
    render

    assert_select "form[action=?][method=?]", component_path(@component), "post" do

      assert_select "input[name=?]", "component[u_location]"

      assert_select "input[name=?]", "component[orientation]"

      assert_select "input[name=?]", "component[part_number]"

      assert_select "input[name=?]", "component[sku]"
    end
  end
end
